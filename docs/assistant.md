# Asistente on-device (Gemma 4 + A2UI)

The assistant runs **Gemma 4 E2B on the phone** through LiteRT-LM
(`flutter_edge_ai` + `flutter_edge_ai_litertlm`). The backend has no chat or
LLM code any more: the model calls the normal expenses REST API through tools,
and answers can include **A2UI** cards rendered with `a2ui_flutter`.

## How it fits together

| Piece | File |
|---|---|
| Model download / chat with tools | `lib/features/assistant/data/assistant_engine.dart` |
| Tools (≤3 args each) and amount parsing | `lib/features/assistant/data/assistant_tools.dart` |
| A2UI prompt, parsing and rendering | `lib/features/assistant/data/a2ui_bridge.dart` |
| Saved history (backend) | `lib/features/assistant/data/assistant_history_repository.dart` |
| Conversation state, system prompt | `lib/features/assistant/presentation/assistant_controller.dart` |
| Screen | `lib/features/assistant/presentation/assistant_screen.dart` |

- **Model**: `LiteRtLmModels.gemma4E2bIt.generic`, file `gemma-4-E2B-it.litertlm`
  (~2.6 GB, Apache-2.0, no Hugging Face token). Downloaded once on first use,
  with progress and cancel. "Borrar el modelo del teléfono" frees the space.
- **Tools**: `resumen_del_mes`, `listar_gastos`, `gastos_fijos_sugeridos`,
  `proponer_gasto`. Writes never happen from the model: `proponer_gasto`
  returns a proposal and the user confirms it on a card. Amounts go as strings
  and are parsed strictly (`AssistantToolExecutor.parseAmount`), because small
  on-device models can garble numbers (e.g. `1.0,293`).
- **A2UI**: the library's generated schema prompt is ~31k characters (~8k
  tokens), more than the 4k-token context. The model gets
  `A2uiBridge.compactInstructions` instead (short rules + one worked example,
  direct-JSON format, catalog pruned to Text/Row/Column/Card/List/Divider/Icon/
  Button). Every block is still validated by `a2ui_agent`; invalid UI is
  dropped and the text kept. Surface ids are made unique app-side.
- **Context**: 4096 tokens. When the conversation gets long the chat is
  reopened with a notice (the model forgets earlier turns; the screen keeps
  them).
- **History**: shared by the household and saved in the backend
  (`/api/assistant`, table `ChatMessage` with a `conversationId`). Every
  member sees every conversation and can continue it; messages show who wrote
  them. Each turn stores the user message, any expense proposals (with their
  confirmed/discarded status) and the raw model reply, so A2UI cards are
  re-rendered on load. Which conversation is open is remembered **per phone**
  (SharedPreferences): when another member starts a new chat it only appears
  first in the "Conversaciones" list, it never switches your screen. On
  opening a conversation its last ~3k characters are replayed into the model
  so it remembers context. No live sync yet: other members' new messages show
  up when the conversation is reopened.

## Platform setup

- **Android**: `minSdk = 30` (Android 11+), arm64 only. Set in
  `android/app/build.gradle.kts`. `INTERNET` permission is already declared.
- **iOS** (not built yet in this repo; there is no `ios/Podfile` until the
  first `pod install` on a Mac). Before building:
  - `platform :ios, '15.0'` and `use_frameworks! :linkage => :static` in the
    Podfile (or deployment target 15.0 with Swift Package Manager);
  - entitlements `com.apple.developer.kernel.extended-virtual-addressing`,
    `com.apple.developer.kernel.increased-memory-limit` (and
    `increased-debugging-memory-limit` for debug).
  - The simulator runs on CPU only.
- **Web**: not enabled. The plugin's web support is a preview (WebGPU, E2B
  only, extra JS files in `web/`); the screen shows "usalo desde la app".

## Known limits

- Not run on a real device yet from this repo: compile and unit tests only.
  Check speed and RAM on a mid-range phone before release (published numbers
  are flagship-only).
- Tool calling with E2B is not fully reliable (community evals around 70%);
  the confirmation card and strict amount parsing are the safety net.

## Future: recipes and weekly menu

`InferenceModel.openChat` accepts a `loraPath`, so a recipe fine-tune of
Gemma 4 E2B (LoRA trained on world recipes) can ship as a small adapter file
on top of the same base model, loaded only for the recipe / weekly-menu chat.
