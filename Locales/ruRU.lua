-- Dejunk: ruRU (Russian) localization file.
-- Translation by Hubbotu (https://wow.curseforge.com/members/Hubbotu).

local AddonName, AddonTable = ...
local L = LibStub('AceLocale-3.0'):NewLocale(AddonName, 'ruRU')
if not L then return end

L["ADDED_ITEM_TO_LIST"] = "Добавлено %s к %s."
L["AUTO_DESTROY_TEXT"] = "Авторазрушение"
L["AUTO_DESTROY_TOOLTIP"] = "Периодически уничтожает ненужные предметы, пока это окно закрыто."
L["AUTO_REPAIR_TEXT"] = "Авторемонт"
L["AUTO_REPAIR_TOOLTIP"] = "Автоматически чинит экипировку при открытии торгового окна."
L["AUTO_SELL_TEXT"] = "Автопродажа"
L["AUTO_SELL_TOOLTIP"] = "Автоматически продавать нежелательные предметы при открытии торгового окна."
L["BACK_TEXT"] = "Назад"
L["BINDINGS_ADD_TO_LIST_TEXT"] = "Добавить в %s"
L["BINDINGS_REMOVE_FROM_LIST_TEXT"] = "Удалить из %s"
L["BINDINGS_TOGGLE_OPTIONS_TEXT"] = "Параметры переключения"
L["BY_CATEGORY_TEXT"] = "По категории"
L["BY_QUALITY_TEXT"] = "По качеству"
L["BY_TYPE_TEXT"] = "По типу"
L["CANNOT_DEJUNK_WHILE_DESTROYING"] = "Невозможно разделить во время уничтожения предметов."
L["CANNOT_DEJUNK_WHILE_LISTS_UPDATING"] = "Нельзя удалять, пока обновляется %s и %s."
L["CANNOT_DESTROY_WHILE_DEJUNKING"] = "Невозможно уничтожить во время удаления предметов."
L["CANNOT_DESTROY_WHILE_LIST_UPDATING"] = "Невозможно уничтожить, пока обновляется %s."
L["CHARACTER_SPECIFIC_TEXT"] = "Настройки персонажа"
L["CHARACTER_SPECIFIC_TOOLTIP"] = "Нажмите эту кнопку, чтобы переключиться между глобальными настройками и настройками, характерными для этого персонажа."
L["COLOR_SCHEME_SET_TEXT"] = "Цветовая схема, установленная для %s."
L["COLOR_SCHEME_TEXT"] = "Цвет"
L["COMMON_TEXT"] = "Обычное"
L["DEJUNK_BUTTON_TOOLTIP"] = "Щелкните правой кнопкой мыши для переключения параметров."
L["DEJUNKING_IN_PROGRESS"] = "Уничтожение уже идет. "
L["DESTROY_ALL_TOOLTIP"] = "Уничтожьте все предметы этого качества."
L["DESTROY_IGNORE_LIST_TOOLTIP"] = "Игнорировать все предметы в списке %s."
L["DESTROY_LIST_TOOLTIP"] = "Уничтожьте все предметы в списке %s."
L["DESTROY_PETS_ALREADY_COLLECTED_TEXT"] = "Собранные Питомцы"
L["DESTROY_PETS_ALREADY_COLLECTED_TOOLTIP"] = "Уничтожает питомцев если у вас есть в коллекции хотя бы один.|n|nТолько для питомцев, которые не могут быть проданы."
L["DESTROY_TEXT"] = "Уничтожить"
L["DESTROY_TOYS_ALREADY_COLLECTED_TEXT"] = "Собранные Игрушки"
L["DESTROY_TOYS_ALREADY_COLLECTED_TOOLTIP"] = "Уничтожьте игрушки, которые вы уже собрали.|n|nНе относится к игрушкам, которые нельзя продать."
L["DESTROYABLES_TEXT"] = "Разрушение"
L["DESTROYABLES_TOOLTIP"] = "Предметы в этом списке будут уничтожены, если не будут проигнорированы опциями."
L["DESTROYED_ITEM"] = "Уничтожен 1 мусор."
L["DESTROYED_ITEM_VERBOSE"] = "Уничтожено: %s."
L["DESTROYED_ITEMS"] = "Уничтожено %s ненужных предметов."
L["DESTROYED_ITEMS_VERBOSE"] = "Уничтожено: %sx%s."
L["DESTROYING_IN_PROGRESS"] = "Уничтожение уже идет."
L["EPIC_TEXT"] = "Эпическое"
L["EXCLUSIONS_TEXT"] = "Белый Список"
L["EXCLUSIONS_TOOLTIP"] = "Предметы в этом списке никогда не будут проданы."
L["EXPORT_HELPER_TEXT"] = "Когда выделено, используйте <Ctrl+C> или <Cmd+C>, чтобы скопировать строку экспорта выше."
L["EXPORT_LABEL_TEXT"] = "Строки Экспорта"
L["EXPORT_TEXT"] = "Экспорт"
L["EXPORT_TITLE_TEXT"] = "Экспорт из %s"
L["FAILED_TO_PARSE_ITEM_ID"] = "ID предмета %s не удалось проанализировать, возможно он не существует."
L["GENERAL_TEXT"] = "Общие"
L["IGNORE_BATTLEPETS_TEXT"] = "Питомцы"
L["IGNORE_BATTLEPETS_TOOLTIP"] = "Игнорируйте боевых и обычных питомцев."
L["IGNORE_BOE_TEXT"] = "Персональные при надевании"
L["IGNORE_BOE_TOOLTIP"] = "Игнорировать предметы персональные при надевании. "
L["IGNORE_CONSUMABLES_TEXT"] = "Расходные материалы"
L["IGNORE_CONSUMABLES_TOOLTIP"] = "Игнорируйте расходные материалы, такие как еда, зелья и сила артефакта."
L["IGNORE_COSMETIC_TEXT"] = "Косметические"
L["IGNORE_COSMETIC_TOOLTIP"] = "Игнорируйте косметические и фамильные предметы, такие как накидки, рубашки и предметы для левой руки."
L["IGNORE_EQUIPMENT_SETS_TEXT"] = "Комплекты экипировки"
L["IGNORE_EQUIPMENT_SETS_TOOLTIP"] = "Игнорировать предметы, принадлежащие сетам."
L["IGNORE_GEMS_TEXT"] = "Камни"
L["IGNORE_GEMS_TOOLTIP"] = "Игнорировать камни и реликвии артефакта. "
L["IGNORE_GLYPHS_TEXT"] = "Символы"
L["IGNORE_GLYPHS_TOOLTIP"] = "Игнорировать символы."
L["IGNORE_ITEM_ENHANCEMENTS_TEXT"] = "Предметы Наложения Чар"
L["IGNORE_ITEM_ENHANCEMENTS_TOOLTIP"] = "Игнорировать предметы которые используются в наложении чар."
L["IGNORE_RECIPES_TEXT"] = "Рецепты"
L["IGNORE_RECIPES_TOOLTIP"] = "Игнорировать рецепты которые можно продать."
L["IGNORE_SOULBOUND_TEXT"] = "Персональные"
L["IGNORE_SOULBOUND_TOOLTIP"] = "Игнорировать персональные предметы."
L["IGNORE_TEXT"] = "Игнорировать"
L["IGNORE_TRADE_GOODS_TEXT"] = "Хозяйственные товары"
L["IGNORE_TRADE_GOODS_TOOLTIP"] = "Игнорировать предметы, связанные с профессиями."
L["IGNORE_TRADEABLE_TEXT"] = "Передаваемые"
L["IGNORE_TRADEABLE_TOOLTIP"] = "Игнорировать предметы, которые можно передать другим игрокам в подземелье или рейде."
L["IMPORT_HELPER_TEXT"] = "Введите ID предмета, разделенный точкой с запятой (e.g. 4983;58907;67410)."
L["IMPORT_LABEL_TEXT"] = "Строка импорта"
L["IMPORT_TEXT"] = "Импорт"
L["IMPORT_TITLE_TEXT"] = "Импорт в %s"
L["INCLUSIONS_TEXT"] = "Черный Список"
L["INCLUSIONS_TOOLTIP"] = "Предметы в этом списке всегда будут продаваться."
L["ITEM_ALREADY_ON_LIST"] = "%s уже на %s."
L["ITEM_CANNOT_BE_DESTROYED"] = "%s не может быть уничтожена."
L["ITEM_CANNOT_BE_SOLD"] = "%s не может быть продан."
L["ITEM_NOT_ON_LIST"] = "%s не включен %s."
L["ITEM_TOOLTIP_TEXT"] = "Подсказка по предмету"
L["ITEM_TOOLTIP_TOOLTIP"] = "Отобразите сообщение Dejunk в подсказке предмета, указывающее, будет ли оно продано. Удерживайте <Shift>, чтобы указать, будет ли он уничтожен.|n|nУдерживайте <Alt> или <Shift+Alt>, чтобы отобразить причину.|n|nЭта всплывающая подсказка применяется только при получении предметов в ваши сумки."
L["ITEM_WILL_BE_DESTROYED"] = "Этот предмет будет уничтожен."
L["ITEM_WILL_BE_SOLD"] = "Этот предмет будет продан."
L["ITEM_WILL_NOT_BE_DESTROYED"] = "Этот предмет не будет уничтожен."
L["ITEM_WILL_NOT_BE_SOLD"] = "Этот предмет не будет продан."
L["LIST_FRAME_ADD_TOOLTIP"] = "Чтобы добавить предмет, переместите его в рамку ниже. (Предметы могут быть добавлены только из ваших сумок и инвентаря.)"
L["LIST_FRAME_REM_ALL_TOOLTIP"] = "Чтобы удалить все предметы, удерживайте нажатой клавишу <Shift+Alt> и щелкните правой кнопкой мыши по заголовку."
L["LIST_FRAME_REM_TOOLTIP"] = "Чтобы удалить предмет, выделите запись и щелкните правой кнопкой мыши."
L["MAY_NOT_HAVE_DESTROYED_ITEM"] = "Может не уничтожить %s."
L["MAY_NOT_HAVE_SOLD_ITEM"] = "Может и не продали %s."
L["MINIMAP_CHECKBUTTON_TEXT"] = "Значок Миникарты"
L["MINIMAP_CHECKBUTTON_TOOLTIP"] = "Отображение значка Dejunk на миникарте."
L["MINIMAP_ICON_TOOLTIP_1"] = "Щелкните левой кнопкой мыши для входа в меню."
L["MINIMAP_ICON_TOOLTIP_2"] = "Щелкните правой кнопкой мыши, чтобы начать уничтожение."
L["MINIMAP_ICON_TOOLTIP_3"] = "Вы можете перетащить этот значок."
L["NO_CACHED_DESTROYABLE_ITEMS"] = "Невозможно восстановить уничтожимые нежелательные предметы. Попробуйте позже."
L["NO_CACHED_JUNK_ITEMS"] = "Никакие нежелательные предметы не могут быть восстановлены. Попробуйте позже."
L["NO_DESTROYABLE_ITEMS"] = "Нет ненужных предметов для уничтожения."
L["NO_JUNK_ITEMS"] = "Нет ненужных предметов для продажи."
L["ONLY_DESTROYING_CACHED"] = "Некоторые предметы не могут быть восстановлены. Только уничтожение ненужных предметов в памяти."
L["ONLY_SELLING_CACHED"] = "Некоторые предметы не могут быть восстановлены. Продавать только предметы в памяти."
L["OPTIONS_TEXT"] = "Опции"
L["POOR_TEXT"] = "Низкое"
L["PRICE_THRESHOLD_TEXT"] = "Порог цены"
L["PRICE_THRESHOLD_TOOLTIP"] = "Уничтожьте ненужные предметы или стопки ненужных предметов, стоимость которых меньше заданной цены."
L["RARE_TEXT"] = "Редкое"
L["REASON_DESTROY_BY_QUALITY_TEXT"] = "Предметы этого качества уничтожаются."
L["REASON_DESTROY_IGNORE_EXCLUSIONS_TEXT"] = "Предметы в списке игнорируются."
L["REASON_DESTROY_INCLUSIONS_TEXT"] = "Предметы в этом списке уничтожаются."
L["REASON_DESTROY_PETS_ALREADY_COLLECTED_TEXT"] = "Питомцы которые уже есть в коллекции уничтожаются."
L["REASON_DESTROY_THRESHOLD_MET_TEXT"] = "Установлен порог цены %s."
L["REASON_DESTROY_THRESHOLD_NOT_MET_TEXT"] = "Недопустимый порог цены %s."
L["REASON_DESTROY_TOYS_ALREADY_COLLECTED_TEXT"] = "Игрушка которая уже есть в коллекции уничтожается."
L["REASON_IGNORE_BATTLEPETS_TEXT"] = "Игнорировать Питомцев."
L["REASON_IGNORE_BOE_TEXT"] = "Предметы персональные при надевании игнорировать."
L["REASON_IGNORE_CONSUMABLES_TEXT"] = "Расходные материалы игнорируются."
L["REASON_IGNORE_COSMETIC_TEXT"] = "Предметы косметики игнорируются."
L["REASON_IGNORE_EQUIPMENT_ABOVE_ILVL_TEXT"] = "Экипировка уровня %s+ игнорируется."
L["REASON_IGNORE_EQUIPMENT_SETS_TEXT"] = "Сетовые куски игнорируются."
L["REASON_IGNORE_GEMS_TEXT"] = "Камни игнорируются."
L["REASON_IGNORE_GLYPHS_TEXT"] = "Символы игнорируются."
L["REASON_IGNORE_ITEM_ENHANCEMENTS_TEXT"] = "Предметы наложения чар игнорируются."
L["REASON_IGNORE_RECIPES_TEXT"] = "Рецепты игнорируются."
L["REASON_IGNORE_SOULBOUND_TEXT"] = "Персональные предметы игнорируются."
L["REASON_IGNORE_TRADE_GOODS_TEXT"] = "Товары для торговли игнорируются."
L["REASON_IGNORE_TRADEABLE_TEXT"] = "Предметы для торговли игнорируются."
L["REASON_ITEM_NOT_FILTERED_TEXT"] = "Этот предмет не фильтруется."
L["REASON_ITEM_ON_LIST_TEXT"] = "Этот предмет включен %s."
L["REASON_SELL_BY_QUALITY_TEXT"] = "Предметы этого качества продаются."
L["REASON_SELL_EQUIPMENT_BELOW_ILVL_TEXT"] = "Экипировка этого уровня %s продается."
L["REASON_SELL_UNSUITABLE_TEXT"] = "В настоящее время продается неподходящая экипировка."
L["REMOVED_ALL_FROM_LIST"] = "Удалить все предметы из %s."
L["REMOVED_ITEM_FROM_LIST"] = "Удалено %s из %s."
L["REPAIRED_ALL_ITEMS"] = "Отремонтированы все предметы для %s."
L["REPAIRED_ALL_ITEMS_GUILD"] = "Отремонтированы все предметы для %s (Гильдия)."
L["REPAIRED_NO_ITEMS"] = "Недостаточно денег на ремонт."
L["REPAIRING_TEXT"] = "Ремонт"
L["SAFE_MODE_MESSAGE"] = "Безопасный режим включен: продается только %s."
L["SAFE_MODE_TEXT"] = "Безопасный режим"
L["SAFE_MODE_TOOLTIP"] = "Только продавать до %s за раз."
L["SCALE_TEXT"] = "Масштаб"
L["SCHEME_NAME_DEFAULT"] = "По умолчанию"
L["SCHEME_NAME_GRAY"] = "Серый"
L["SCHEME_NAME_GREEN"] = "Зеленый"
L["SCHEME_NAME_PURPLE"] = "Пурпурный"
L["SCHEME_NAME_RED"] = "Красный"
L["SELL_ALL_TOOLTIP"] = "Продавайте все предметы этого качества."
L["SELL_EQUIPMENT_BELOW_ILVL_TEXT"] = "Экипировка низкого уровня"
L["SELL_EQUIPMENT_BELOW_ILVL_TOOLTIP"] = "Продавайте все предметы, имеющие определенный уровень предмета.|n|nВыбранные предметы общего качества или выше с уровнем предмета, большим или равным указанному уровню предмета, будут проигнорированы.|n|nКосметические предметы и рыбные пиры не подвержены этой настройке."
L["SELL_TEXT"] = "Продавать"
L["SELL_UNSUITABLE_TEXT"] = "Неподходящая экипировка"
L["SELL_UNSUITABLE_TOOLTIP"] = "Продайте все оружие, которое непригодно для вашего класса, и продайте все доспехи, которые не соответствуют типу вашего класса."
L["SELLING_TEXT"] = "Продажа"
L["SILENT_MODE_TEXT"] = "Бесшумный режим"
L["SILENT_MODE_TOOLTIP"] = "Отключить сообщения окна чата Dejunk."
L["SOLD_ITEM_VERBOSE"] = "Продан: %s."
L["SOLD_ITEMS_VERBOSE"] = "Продан: %sx%s."
L["SOLD_YOUR_JUNK"] = "Продан ваш мусор на %s."
L["START_DESTROYING_BUTTON_TEXT"] = "Начать уничтожение"
L["UNCOMMON_TEXT"] = "Необычное"
L["USE_GUILD_REPAIR_TEXT"] = "Использовать гильдию"
L["USE_GUILD_REPAIR_TOOLTIP"] = "Приоритет ремонта гильдии, когда он доступен."
L["VENDOR_DOESNT_BUY"] = "Нельзя продать этому торговцу."
L["VERBOSE_MODE_TEXT"] = "Подробный режим"
L["VERBOSE_MODE_TOOLTIP"] = "Включите дополнительные сообщения окна чата Dejunk при продаже и уничтожении предметов."
