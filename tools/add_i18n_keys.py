import json, os

BASE = r"C:\Users\yusuf\Desktop\Momentra\momentra-master\momentra-master\src\i18n"

TRANSLATIONS = {
    "tr": {
        "budget.tracker_title": "Butce Takibi",
        "budget.spent": "Harcanan",
        "budget.paid": "Odenen",
        "budget.remaining": "Kalan",
        "budget.category_breakdown": "Kategori Dagilimi",
        "budget.over_budget_warning": "Butceyi {{currency}}{{amount}} astiniz!",
        "photos.title": "Fotograflar",
        "photos.add_photos": "Fotograf Ekle",
        "photos.delete_confirm": "Bu fotografi silmek istediginize emin misiniz?",
    },
    "en": {
        "budget.tracker_title": "Budget Tracker",
        "budget.spent": "Spent",
        "budget.paid": "Paid",
        "budget.remaining": "Remaining",
        "budget.category_breakdown": "Category Breakdown",
        "budget.over_budget_warning": "Over budget by {{currency}}{{amount}}!",
        "photos.title": "Photos",
        "photos.add_photos": "Add photos",
        "photos.delete_confirm": "Delete this photo?",
    },
    "de": {
        "budget.tracker_title": "Budgetverfolgung",
        "budget.spent": "Ausgegeben",
        "budget.paid": "Bezahlt",
        "budget.remaining": "Verbleibend",
        "budget.category_breakdown": "Kategorieaufschlusselung",
        "budget.over_budget_warning": "Budget um {{currency}}{{amount}} uberschritten!",
        "photos.title": "Fotos",
        "photos.add_photos": "Fotos hinzufugen",
        "photos.delete_confirm": "Mochten Sie dieses Foto wirklich loschen?",
    },
    "fr": {
        "budget.tracker_title": "Suivi du budget",
        "budget.spent": "Depense",
        "budget.paid": "Paye",
        "budget.remaining": "Restant",
        "budget.category_breakdown": "Repartition par categorie",
        "budget.over_budget_warning": "Budget depasse de {{currency}}{{amount}} !",
        "photos.title": "Photos",
        "photos.add_photos": "Ajouter des photos",
        "photos.delete_confirm": "Voulez-vous vraiment supprimer cette photo ?",
    },
    "es": {
        "budget.tracker_title": "Control de presupuesto",
        "budget.spent": "Gastado",
        "budget.paid": "Pagado",
        "budget.remaining": "Restante",
        "budget.category_breakdown": "Desglose por categoria",
        "budget.over_budget_warning": "Presupuesto superado en {{currency}}{{amount}}!",
        "photos.title": "Fotos",
        "photos.add_photos": "Agregar fotos",
        "photos.delete_confirm": "Estas seguro de que quieres eliminar esta foto?",
    },
    "it": {
        "budget.tracker_title": "Monitoraggio budget",
        "budget.spent": "Speso",
        "budget.paid": "Pagato",
        "budget.remaining": "Rimanente",
        "budget.category_breakdown": "Ripartizione per categoria",
        "budget.over_budget_warning": "Budget superato di {{currency}}{{amount}}!",
        "photos.title": "Foto",
        "photos.add_photos": "Aggiungi foto",
        "photos.delete_confirm": "Sei sicuro di voler eliminare questa foto?",
    },
    "pt": {
        "budget.tracker_title": "Controle de orcamento",
        "budget.spent": "Gasto",
        "budget.paid": "Pago",
        "budget.remaining": "Restante",
        "budget.category_breakdown": "Divisao por categoria",
        "budget.over_budget_warning": "Orcamento ultrapassado em {{currency}}{{amount}}!",
        "photos.title": "Fotos",
        "photos.add_photos": "Adicionar fotos",
        "photos.delete_confirm": "Tem certeza que deseja excluir esta foto?",
    },
    "ru": {
        "budget.tracker_title": "\u041e\u0442\u0441\u043b\u0435\u0436\u0438\u0432\u0430\u043d\u0438\u0435 \u0431\u044e\u0434\u0436\u0435\u0442\u0430",
        "budget.spent": "\u041f\u043e\u0442\u0440\u0430\u0447\u0435\u043d\u043e",
        "budget.paid": "\u041e\u043f\u043b\u0430\u0447\u0435\u043d\u043e",
        "budget.remaining": "\u041e\u0441\u0442\u0430\u0442\u043e\u043a",
        "budget.category_breakdown": "\u0420\u0430\u0437\u0431\u0438\u0432\u043a\u0430 \u043f\u043e \u043a\u0430\u0442\u0435\u0433\u043e\u0440\u0438\u044f\u043c",
        "budget.over_budget_warning": "\u0411\u044e\u0434\u0436\u0435\u0442 \u043f\u0440\u0435\u0432\u044b\u0448\u0435\u043d \u043d\u0430 {{currency}}{{amount}}!",
        "photos.title": "\u0424\u043e\u0442\u043e\u0433\u0440\u0430\u0444\u0438\u0438",
        "photos.add_photos": "\u0414\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u0444\u043e\u0442\u043e",
        "photos.delete_confirm": "\u0412\u044b \u0443\u0432\u0435\u0440\u0435\u043d\u044b, \u0447\u0442\u043e \u0445\u043e\u0442\u0438\u0442\u0435 \u0443\u0434\u0430\u043b\u0438\u0442\u044c \u044d\u0442\u043e \u0444\u043e\u0442\u043e?",
    },
    "ar": {
        "budget.tracker_title": "\u062a\u062a\u0628\u0639 \u0627\u0644\u0645\u064a\u0632\u0627\u0646\u064a\u0629",
        "budget.spent": "\u0627\u0644\u0645\u064f\u0646\u0641\u064e\u0642",
        "budget.paid": "\u0627\u0644\u0645\u062f\u0641\u0648\u0639",
        "budget.remaining": "\u0627\u0644\u0645\u062a\u0628\u0642\u064a",
        "budget.category_breakdown": "\u0627\u0644\u062a\u0648\u0632\u064a\u0639 \u062d\u0633\u0628 \u0627\u0644\u0641\u0626\u0629",
        "budget.over_budget_warning": "\u062a\u062c\u0627\u0648\u0632 \u0627\u0644\u0645\u064a\u0632\u0627\u0646\u064a\u0629 \u0628\u0645\u0642\u062f\u0627\u0631 {{currency}}{{amount}}!",
        "photos.title": "\u0627\u0644\u0635\u0648\u0631",
        "photos.add_photos": "\u0625\u0636\u0627\u0641\u0629 \u0635\u0648\u0631",
        "photos.delete_confirm": "\u0647\u0644 \u0623\u0646\u062a \u0645\u062a\u0623\u0643\u062f \u0645\u0646 \u062d\u0630\u0641 \u0647\u0630\u0647 \u0627\u0644\u0635\u0648\u0631\u0629\u061f",
    },
    "ja": {
        "budget.tracker_title": "\u4e88\u7b97\u8ffd\u8de1",
        "budget.spent": "\u652f\u51fa",
        "budget.paid": "\u652f\u6255\u6e08",
        "budget.remaining": "\u6b8b\u308a",
        "budget.category_breakdown": "\u30ab\u30c6\u30b4\u30ea\u5225\u5185\u8a33",
        "budget.over_budget_warning": "\u4e88\u7b97\u3092{{currency}}{{amount}}\u8d85\u904e\u3057\u307e\u3057\u305f\uff01",
        "photos.title": "\u5199\u771f",
        "photos.add_photos": "\u5199\u771f\u3092\u8ffd\u52a0",
        "photos.delete_confirm": "\u3053\u306e\u5199\u771f\u3092\u524a\u9664\u3057\u3066\u3082\u3088\u308d\u3057\u3044\u3067\u3059\u304b\uff1f",
    },
    "ko": {
        "budget.tracker_title": "\uc608\uc0b0 \ucd94\uc801",
        "budget.spent": "\uc9c0\ucd9c",
        "budget.paid": "\uc9c0\ubd88\ub428",
        "budget.remaining": "\uc794\uc561",
        "budget.category_breakdown": "\uce74\ud14c\uace0\ub9ac\ubcc4 \ub0b4\uc5ed",
        "budget.over_budget_warning": "\uc608\uc0b0 {{currency}}{{amount}} \ucd08\uacfc!",
        "photos.title": "\uc0ac\uc9c4",
        "photos.add_photos": "\uc0ac\uc9c4 \ucd94\uac00",
        "photos.delete_confirm": "\uc774 \uc0ac\uc9c4\uc744 \uc0ad\uc81c\ud558\uc2dc\uaca0\uc2b5\ub2c8\uae4c?",
    },
    "zh": {
        "budget.tracker_title": "\u9884\u7b97\u8ffd\u8e2a",
        "budget.spent": "\u5df2\u82b1\u8d39",
        "budget.paid": "\u5df2\u652f\u4ed8",
        "budget.remaining": "\u5269\u4f59",
        "budget.category_breakdown": "\u5206\u7c7b\u660e\u7ec6",
        "budget.over_budget_warning": "\u9884\u7b97\u8d85\u652f {{currency}}{{amount}}\uff01",
        "photos.title": "\u7167\u7247",
        "photos.add_photos": "\u6dfb\u52a0\u7167\u7247",
        "photos.delete_confirm": "\u786e\u5b9a\u8981\u5220\u9664\u8fd9\u5f20\u7167\u7247\u5417\uff1f",
    },
    "hi": {
        "budget.tracker_title": "\u092c\u091c\u091f \u091f\u094d\u0930\u0948\u0915\u0930",
        "budget.spent": "\u0916\u0930\u094d\u091a \u0915\u093f\u092f\u093e",
        "budget.paid": "\u092d\u0941\u0917\u0924\u093e\u0928 \u0915\u093f\u092f\u093e",
        "budget.remaining": "\u0936\u0947\u0937",
        "budget.category_breakdown": "\u0936\u094d\u0930\u0947\u0923\u0940 \u0915\u0947 \u0905\u0928\u0941\u0938\u093e\u0930 \u0935\u093f\u0935\u0930\u0923",
        "budget.over_budget_warning": "\u092c\u091c\u091f {{currency}}{{amount}} \u0938\u0947 \u0905\u0927\u093f\u0915 \u0939\u094b \u0917\u092f\u093e!",
        "photos.title": "\u0924\u0938\u094d\u0935\u0940\u0930\u0947\u0902",
        "photos.add_photos": "\u0924\u0938\u094d\u0935\u0940\u0930\u0947\u0902 \u091c\u094b\u0921\u093c\u0947\u0902",
        "photos.delete_confirm": "\u0915\u094d\u092f\u093e \u0906\u092a \u0935\u093e\u0915\u0908 \u0907\u0938 \u0924\u0938\u094d\u0935\u0940\u0930 \u0915\u094b \u0939\u091f\u093e\u0928\u093e \u091a\u093e\u0939\u0924\u0947 \u0939\u0948\u0902?",
    },
    "nl": {
        "budget.tracker_title": "Budgetbewaking",
        "budget.spent": "Uitgegeven",
        "budget.paid": "Betaald",
        "budget.remaining": "Resterend",
        "budget.category_breakdown": "Uitsplitsing per categorie",
        "budget.over_budget_warning": "Budget overschreden met {{currency}}{{amount}}!",
        "photos.title": "Foto's",
        "photos.add_photos": "Foto's toevoegen",
        "photos.delete_confirm": "Weet je zeker dat je deze foto wilt verwijderen?",
    },
    "pl": {
        "budget.tracker_title": "Sledzenie budzetu",
        "budget.spent": "Wydano",
        "budget.paid": "Zaplacono",
        "budget.remaining": "Pozostalo",
        "budget.category_breakdown": "Podzial wedlug kategorii",
        "budget.over_budget_warning": "Przekroczono budzet o {{currency}}{{amount}}!",
        "photos.title": "Zdjecia",
        "photos.add_photos": "Dodaj zdjecia",
        "photos.delete_confirm": "Czy na pewno chcesz usunac to zdjecie?",
    },
    "sv": {
        "budget.tracker_title": "Budgetsparing",
        "budget.spent": "Spenderat",
        "budget.paid": "Betalt",
        "budget.remaining": "Aterstaende",
        "budget.category_breakdown": "Kategoriuppdelning",
        "budget.over_budget_warning": "Budgeten overskreds med {{currency}}{{amount}}!",
        "photos.title": "Foton",
        "photos.add_photos": "Lagg till foton",
        "photos.delete_confirm": "Ar du saker pa att du vill ta bort det har fotot?",
    },
    "uk": {
        "budget.tracker_title": "\u0412\u0456\u0434\u0441\u0442\u0435\u0436\u0435\u043d\u043d\u044f \u0431\u044e\u0434\u0436\u0435\u0442\u0443",
        "budget.spent": "\u0412\u0438\u0442\u0440\u0430\u0447\u0435\u043d\u043e",
        "budget.paid": "\u0421\u043f\u043b\u0430\u0447\u0435\u043d\u043e",
        "budget.remaining": "\u0417\u0430\u043b\u0438\u0448\u043e\u043a",
        "budget.category_breakdown": "\u0420\u043e\u0437\u0431\u0438\u0432\u043a\u0430 \u0437\u0430 \u043a\u0430\u0442\u0435\u0433\u043e\u0440\u0456\u044f\u043c\u0438",
        "budget.over_budget_warning": "\u0411\u044e\u0434\u0436\u0435\u0442 \u043f\u0435\u0440\u0435\u0432\u0438\u0449\u0435\u043d\u043e \u043d\u0430 {{currency}}{{amount}}!",
        "photos.title": "\u0424\u043e\u0442\u043e\u0433\u0440\u0430\u0444\u0456\u0457",
        "photos.add_photos": "\u0414\u043e\u0434\u0430\u0442\u0438 \u0444\u043e\u0442\u043e",
        "photos.delete_confirm": "\u0412\u0438 \u0432\u043f\u0435\u0432\u043d\u0435\u043d\u0456, \u0449\u043e \u0445\u043e\u0447\u0435\u0442\u0435 \u0432\u0438\u0434\u0430\u043b\u0438\u0442\u0438 \u0446\u0435 \u0444\u043e\u0442\u043e?",
    },
}

# Fix Turkish values with proper Unicode characters
TRANSLATIONS["tr"]["budget.tracker_title"] = "B\u00fct\u00e7e Takibi"
TRANSLATIONS["tr"]["budget.paid"] = "\u00d6denen"
TRANSLATIONS["tr"]["budget.category_breakdown"] = "Kategori Da\u011f\u0131l\u0131m\u0131"
TRANSLATIONS["tr"]["budget.over_budget_warning"] = "B\u00fct\u00e7eyi {{currency}}{{amount}} a\u015ft\u0131n\u0131z!"
TRANSLATIONS["tr"]["photos.title"] = "Foto\u011fraflar"
TRANSLATIONS["tr"]["photos.add_photos"] = "Foto\u011fraf Ekle"
TRANSLATIONS["tr"]["photos.delete_confirm"] = "Bu foto\u011fraf\u0131 silmek istedi\u011finize emin misiniz?"

# Fix German values
TRANSLATIONS["de"]["budget.category_breakdown"] = "Kategorieaufschl\u00fcsselung"
TRANSLATIONS["de"]["budget.over_budget_warning"] = "Budget um {{currency}}{{amount}} \u00fcberschritten!"
TRANSLATIONS["de"]["photos.add_photos"] = "Fotos hinzuf\u00fcgen"
TRANSLATIONS["de"]["photos.delete_confirm"] = "M\u00f6chten Sie dieses Foto wirklich l\u00f6schen?"

# Fix French values
TRANSLATIONS["fr"]["budget.spent"] = "D\u00e9pens\u00e9"
TRANSLATIONS["fr"]["budget.paid"] = "Pay\u00e9"
TRANSLATIONS["fr"]["budget.category_breakdown"] = "R\u00e9partition par cat\u00e9gorie"
TRANSLATIONS["fr"]["budget.over_budget_warning"] = "Budget d\u00e9pass\u00e9 de {{currency}}{{amount}} !"

# Fix Spanish values
TRANSLATIONS["es"]["budget.category_breakdown"] = "Desglose por categor\u00eda"
TRANSLATIONS["es"]["budget.over_budget_warning"] = "\u00a1Presupuesto superado en {{currency}}{{amount}}!"
TRANSLATIONS["es"]["photos.delete_confirm"] = "\u00bfEst\u00e1s seguro de que quieres eliminar esta foto?"

# Fix Portuguese values
TRANSLATIONS["pt"]["budget.tracker_title"] = "Controle de or\u00e7amento"
TRANSLATIONS["pt"]["budget.category_breakdown"] = "Divis\u00e3o por categoria"
TRANSLATIONS["pt"]["budget.over_budget_warning"] = "Or\u00e7amento ultrapassado em {{currency}}{{amount}}!"

# Fix Swedish values
TRANSLATIONS["sv"]["budget.tracker_title"] = "Budgetsp\u00e5rning"
TRANSLATIONS["sv"]["budget.remaining"] = "\u00c5terst\u00e5ende"
TRANSLATIONS["sv"]["budget.over_budget_warning"] = "Budgeten \u00f6verskreds med {{currency}}{{amount}}!"
TRANSLATIONS["sv"]["photos.add_photos"] = "L\u00e4gg till foton"
TRANSLATIONS["sv"]["photos.delete_confirm"] = "\u00c4r du s\u00e4ker p\u00e5 att du vill ta bort det h\u00e4r fotot?"

# Fix Polish values
TRANSLATIONS["pl"]["budget.tracker_title"] = "\u015aledzenie bud\u017cetu"
TRANSLATIONS["pl"]["budget.paid"] = "Zap\u0142acono"
TRANSLATIONS["pl"]["budget.remaining"] = "Pozosta\u0142o"
TRANSLATIONS["pl"]["budget.category_breakdown"] = "Podzia\u0142 wed\u0142ug kategorii"
TRANSLATIONS["pl"]["budget.over_budget_warning"] = "Przekroczono bud\u017cet o {{currency}}{{amount}}!"
TRANSLATIONS["pl"]["photos.title"] = "Zdj\u0119cia"
TRANSLATIONS["pl"]["photos.add_photos"] = "Dodaj zdj\u0119cia"
TRANSLATIONS["pl"]["photos.delete_confirm"] = "Czy na pewno chcesz usun\u0105\u0107 to zdj\u0119cie?"

for lang, keys in TRANSLATIONS.items():
    path = os.path.join(BASE, lang, "common.json")
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    for dotkey, value in keys.items():
        section, key = dotkey.split(".", 1)
        if section not in data:
            data[section] = {}
        data[section][key] = value
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"Updated {lang}/common.json")

print("Done!")
