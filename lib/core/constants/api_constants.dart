/// API endpoint constants for Household Hub backend
class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      'https://nuestra-app-back-production.up.railway.app';

  // Auth
  static const String authGoogle = '/auth/google';
  static const String authApple = '/auth/apple';
  static const String authMe = '/auth/me';

  // Households
  static const String households = '/api/households';
  static String household(String id) => '/api/households/$id';
  static String householdInvite(String id) => '/api/households/$id/invite';
  static String householdInvites(String id) => '/api/households/$id/invites';
  static const String householdJoin = '/api/households/join';
  static String householdMember(String hhId, String uId) =>
      '/api/households/$hhId/members/$uId';

  // Expenses
  static const String expenses = '/api/expenses';
  static const String expenseCategories = '/api/expenses/categories';
  static String expenseCategory(String id) => '/api/expenses/categories/$id';
  static String expense(String id) => '/api/expenses/$id';
  static String expenseSettle(String id) => '/api/expenses/$id/settle';
  static const String expenseSettlePeriod = '/api/expenses/settle-period';
  static const String expenseSummary = '/api/expenses/summary';
  static const String expenseRecalculateSplits = '/api/expenses/recalculate-splits';
  static const String expenseRecurring = '/api/expenses/recurring';
  static String expenseRecurringItem(String id) =>
      '/api/expenses/recurring/$id';
  static const String expenseRecurringGenerate =
      '/api/expenses/recurring/generate';
  static const String expenseBudgets = '/api/expenses/budgets';
  static const String expenseBudgetStatus = '/api/expenses/budgets/status';
  static const String expenseTrends = '/api/expenses/trends';
  static const String expenseExport = '/api/expenses/export';
  static const String expensePredictions = '/api/expenses/predictions';
  static const String expensePredictionsApply =
      '/api/expenses/predictions/apply';

  // Assistant (household-shared history; the model runs on the phone)
  static const String assistantConversations = '/api/assistant/conversations';
  static const String assistantHistory = '/api/assistant/history';
  static const String assistantMessages = '/api/assistant/messages';
  static String assistantMessage(String id) => '/api/assistant/messages/$id';

  // Food: recipes, preferences, menus
  static const String recipes = '/api/recipes';
  static const String recipeSearch = '/api/recipes/search';
  static const String seasonIngredients = '/api/recipes/ingredients/season';
  static String recipe(String slug) => '/api/recipes/$slug';
  static const String foodPreferences = '/api/recipes/preferences';
  static String foodPreference(String id) => '/api/recipes/preferences/$id';
  static const String foodProfile = '/api/menus/profile';
  static const String menuWeek = '/api/menus/week';
  static const String menuCandidates = '/api/menus/candidates';
  static const String menuEntry = '/api/menus/entry';
  static String menuEntryById(String id) => '/api/menus/entry/$id';
  static const String menuCopyPrevious = '/api/menus/copy-previous';
  static const String menuShopping = '/api/menus/shopping';
  static const String menuShoppingCheck = '/api/menus/shopping/check';

  // Activity
  static const String activity = '/api/activity';
  static const String activityDigest = '/api/activity/digest';

  // Upload
  static const String upload = '/api/upload';
}
