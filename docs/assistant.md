# Asistente on-device (Gemma 4)

The assistant runs **Gemma 4 E2B on the phone** through LiteRT-LM
(`flutter_edge_ai` + `flutter_edge_ai_litertlm`). The backend has no LLM code:
it only stores the household's conversations.

## The rule: the model reads, the app answers

A 2B model is good at understanding a short message and bad at numbers,
choosing among many tools, and knowing what it did or did not do. The first
version let it call 11 tools and write cards itself; it garbled amounts
("7.000" → 7.00), claimed things were saved when they were not, leaked tool
names and wrote markdown that was never rendered. So now:

1. **"sí" / "no"** while an expense is waiting on screen saves or discards it,
   in code (`isYes` / `isNo`). No model.
2. The model **reads the message into an `AssistantRequest`**: one action
   (`anotar_gasto`, `consultar_gastos`, `buscar_receta`, `armar_menu`, ...)
   plus fields **copied as written** (`"monto": "7.000"`, `"fecha": "ayer"`).
   Constrained JSON decoding (`ResponseFormat.jsonSchema`) means it cannot
   answer anything else; the category is an enum of the household's names.
   The prompt is short and built on examples.
3. `AssistantActions` **runs the request with the app's data** and returns
   cards. Amounts, dates and months are converted in code
   (`spanish_parsing.dart`: "7.000" = 7000, "15 lucas", "1.029,50", "el
   lunes", "el mes pasado"); totals and lists are computed from the API. The
   category of a new expense comes first from how the household filed the
   same description before.
4. Only small talk (`charlar`) gets text written by the model: short, plain
   text, told it has no data. Any markdown marks are stripped anyway.

The **expense card is the confirmation**: it is editable (amount, description,
date, category) and nothing asks again in text. "Guardado" only appears after
the API saved it.

## Pieces

| Piece | File |
|---|---|
| Model download (resumable), `readJson`, `reply`, photo reading | `data/assistant_engine.dart`, `data/resumable_download.dart` |
| What a message asks for: actions, schema, prompt | `domain/assistant_request.dart` |
| Amounts, dates, months, yes/no in Argentine Spanish | `domain/spanish_parsing.dart` |
| Chat items and cards (saved as JSON) | `domain/chat_items.dart` |
| Request → cards with the app's data | `application/assistant_actions.dart` |
| Week planning | `application/week_planner.dart` |
| Food forms in the chat (A2UI, built by the app) | `data/form_surfaces.dart`, `lib/features/food/forms/` |
| Conversation flow, history | `presentation/assistant_controller.dart` |
| Screen and cards | `presentation/assistant_screen.dart`, `presentation/chat_cards.dart` |

(paths under `lib/features/assistant/`)

## Cards

Gasto para guardar (editable), gastos de algo en un mes, resumen del mes (by
category and by who paid), gastos fijos sin cargar, recetas, menú de la semana,
preferencia guardada (with undo), and links (lista de compras, abrir receta).
Each card stores a snapshot of its data, so a saved conversation looks the
same when reopened; drafts keep their status (pending / saved / discarded).

## Food

- Recipe searches go to the catalog, already filtered by the household's
  preferences. The first food request of a household without a profile shows
  the profile form once per conversation.
- Vague requests ("algo rico") show the "aclarar" form; "tengo arroz y huevos"
  searches with those; with no ingredients, the "heladera" form.
- **Weekly menu**: after the "armar la semana" form the app fills each slot:
  the backend ranks the options that respect the rules, the model picks one
  (its answer is constrained to those ids), a refused pick moves to the next
  option, and "sobras" puts last night's dinner as lunch. Without the model it
  takes the best ranked option.
- **Recipe photos**: a one-off session with structured JSON output reads the
  image; the pre-filled "nueva receta" form lets the user fix it.

## History

Shared by the household and saved in the backend (`/api/assistant`, table
`ChatMessage` with a `conversationId`). Each turn stores the user's message,
the cards (`metadata.kind = "card"`, `metadata.card = {type, ...}`) and model
replies (`kind = "reply"`). Card status changes update the stored metadata.
Old conversations (model replies with A2UI blocks, `kind = "proposal"`) are
still read. The open conversation is remembered per phone.

## Platform setup

- **Android**: `minSdk = 30` (Android 11+), arm64 only.
- **iOS** (not built yet): `platform :ios, '15.0'`, static frameworks, and the
  extended-virtual-addressing / increased-memory-limit entitlements.
- **Web**: not enabled (the screen says to use the phone app).

## Future

`InferenceModel.openChat` accepts a `loraPath`, so a recipe fine-tune of
Gemma 4 E2B can ship as a small adapter on top of the same base model.
