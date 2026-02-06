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

  // Recipes
  static const String recipes = '/api/recipes';
  static String recipe(String id) => '/api/recipes/$id';
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

  // Expenses
  static const String expenses = '/api/expenses';
  static const String expenseCategories = '/api/expenses/categories';
  static String expenseCategory(String id) => '/api/expenses/categories/$id';
  static String expense(String id) => '/api/expenses/$id';
  static String expenseSettle(String id) => '/api/expenses/$id/settle';
  static const String expenseSettlePeriod = '/api/expenses/settle-period';
  static const String expenseSummary = '/api/expenses/summary';

  // Calendar
  static const String calendar = '/api/calendar';
  static String calendarEvent(String id) => '/api/calendar/$id';
  static const String calendarTimeline = '/api/calendar/timeline';

  // Upload
  static const String upload = '/api/upload';
}
