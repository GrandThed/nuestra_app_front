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

  // Boards
  static const String boards = '/api/boards';
  static String board(String id) => '/api/boards/$id';
  static String boardItemLink(String id) => '/api/boards/$id/items/link';
  static String boardItemPhoto(String id) => '/api/boards/$id/items/photo';
  static String boardItem(String bId, String iId) =>
      '/api/boards/$bId/items/$iId';
  static String boardItemReorder(String bId) =>
      '/api/boards/$bId/items/reorder';
  static String boardItemTags(String bId, String iId) =>
      '/api/boards/$bId/items/$iId/tags';
  static String boardItemTag(String bId, String iId, String tId) =>
      '/api/boards/$bId/items/$iId/tags/$tId';
  static String boardItemComments(String bId, String iId) =>
      '/api/boards/$bId/items/$iId/comments';
  static String boardItemComment(String bId, String iId, String cId) =>
      '/api/boards/$bId/items/$iId/comments/$cId';
  static const String boardTags = '/api/boards/tags';
  static String boardTag(String tId) => '/api/boards/tags/$tId';
  static const String boardTemplates = '/api/boards/templates';

  // Recipes
  static const String recipes = '/api/recipes';
  static String recipe(String id) => '/api/recipes/$id';
  static String recipeRating(String id) => '/api/recipes/$id/rating';
  static String recipeRatings(String id) => '/api/recipes/$id/ratings';
  static String recipeFavorite(String id) => '/api/recipes/$id/favorite';
  static const String recipeImportUrl = '/api/recipes/import-url';
  static const String seasonalVegetables = '/api/recipes/seasonal-vegetables';

  // Menus
  static const String menus = '/api/menus';
  static const String menusUpcoming = '/api/menus/upcoming';
  static String menu(String id) => '/api/menus/$id';
  static String menuItems(String id) => '/api/menus/$id/items';
  static String menuItem(String mId, String iId) =>
      '/api/menus/$mId/items/$iId';
  static String menuGenerateShopping(String id) =>
      '/api/menus/$id/generate-shopping';

  // Wishlists
  static const String wishlists = '/api/wishlists';
  static const String wishlistCategories = '/api/wishlists/categories';
  static String wishlistCategory(String id) => '/api/wishlists/categories/$id';
  static String wishlistItem(String id) => '/api/wishlists/$id';
  static const String wishlistBulk = '/api/wishlists/bulk';
  static const String wishlistClearChecked = '/api/wishlists/clear-checked';
  static String wishlistVote(String id) => '/api/wishlists/$id/vote';
  static String wishlistPurchase(String id) => '/api/wishlists/$id/purchase';
  static const String wishlistHistory = '/api/wishlists/history';

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

  // Calendar
  static const String calendar = '/api/calendar';
  static String calendarEvent(String id) => '/api/calendar/$id';
  static const String calendarTimeline = '/api/calendar/timeline';

  // Activity
  static const String activity = '/api/activity';
  static const String activityDigest = '/api/activity/digest';

  // Upload
  static const String upload = '/api/upload';
}
