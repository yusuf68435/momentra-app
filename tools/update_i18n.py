import json

NEW_AUTH_KEYS = {
    "full_name_label": {
        "tr": "Ad Soyad", "en": "Full Name", "de": "Vollständiger Name", "fr": "Nom complet",
        "es": "Nombre completo", "it": "Nome completo", "pt": "Nome completo",
        "ru": "Полное имя", "ar": "الاسم الكامل", "ja": "フルネーム", "ko": "전체 이름",
        "zh": "全名", "hi": "पूरा नाम", "nl": "Volledige naam", "pl": "Imię i nazwisko",
        "sv": "Fullständigt namn", "uk": "Повне ім'я"
    },
    "full_name_placeholder": {
        "tr": "Adınız Soyadınız", "en": "Your Full Name", "de": "Ihr vollständiger Name",
        "fr": "Votre nom complet", "es": "Su nombre completo", "it": "Il tuo nome completo",
        "pt": "Seu nome completo", "ru": "Ваше полное имя", "ar": "اسمك الكامل",
        "ja": "フルネームを入力", "ko": "전체 이름 입력", "zh": "您的全名",
        "hi": "आपका पूरा नाम", "nl": "Uw volledige naam", "pl": "Twoje imię i nazwisko",
        "sv": "Ditt fullständiga namn", "uk": "Ваше повне ім'я"
    },
    "password_placeholder": {
        "tr": "En az 8 karakter", "en": "At least 8 characters", "de": "Mindestens 8 Zeichen",
        "fr": "Au moins 8 caractères", "es": "Al menos 8 caracteres", "it": "Almeno 8 caratteri",
        "pt": "Pelo menos 8 caracteres", "ru": "Не менее 8 символов", "ar": "8 أحرف على الأقل",
        "ja": "8文字以上", "ko": "최소 8자", "zh": "至少8个字符",
        "hi": "कम से कम 8 अक्षर", "nl": "Minimaal 8 tekens", "pl": "Co najmniej 8 znaków",
        "sv": "Minst 8 tecken", "uk": "Щонайменше 8 символів"
    },
    "confirm_password_placeholder": {
        "tr": "Şifrenizi tekrar girin", "en": "Re-enter your password",
        "de": "Passwort erneut eingeben", "fr": "Ressaisissez votre mot de passe",
        "es": "Vuelva a introducir su contraseña", "it": "Reinserisci la tua password",
        "pt": "Redigite sua senha", "ru": "Повторите пароль", "ar": "أعد إدخال كلمة المرور",
        "ja": "パスワードを再入力", "ko": "비밀번호 재입력", "zh": "重新输入密码",
        "hi": "अपना पासवर्ड दोबारा दर्ज करें", "nl": "Voer uw wachtwoord opnieuw in",
        "pl": "Wpisz ponownie hasło", "sv": "Ange lösenordet igen",
        "uk": "Повторіть пароль"
    },
    "terms_accept": {
        "tr": "Kullanım koşullarını ve gizlilik politikasını kabul ediyorum",
        "en": "I accept the terms of service and privacy policy",
        "de": "Ich akzeptiere die Nutzungsbedingungen und Datenschutzrichtlinien",
        "fr": "J'accepte les conditions d'utilisation et la politique de confidentialité",
        "es": "Acepto los términos de servicio y la política de privacidad",
        "it": "Accetto i termini di servizio e la politica sulla privacy",
        "pt": "Aceito os termos de serviço e a política de privacidade",
        "ru": "Я принимаю условия использования и политику конфиденциальности",
        "ar": "أوافق على شروط الخدمة وسياسة الخصوصية",
        "ja": "利用規約とプライバシーポリシーに同意します",
        "ko": "서비스 약관 및 개인정보 처리방침에 동의합니다",
        "zh": "我接受服务条款和隐私政策",
        "hi": "मैं सेवा की शर्तें और गोपनीयता नीति स्वीकार करता/करती हूँ",
        "nl": "Ik accepteer de servicevoorwaarden en het privacybeleid",
        "pl": "Akceptuję regulamin i politykę prywatności",
        "sv": "Jag accepterar användarvillkoren och integritetspolicyn",
        "uk": "Я приймаю умови використання та політику конфіденційності"
    },
    "terms_required": {
        "tr": "Kullanım koşullarını kabul etmelisiniz",
        "en": "You must accept the terms of service",
        "de": "Sie müssen die Nutzungsbedingungen akzeptieren",
        "fr": "Vous devez accepter les conditions d'utilisation",
        "es": "Debe aceptar los términos de servicio",
        "it": "È necessario accettare i termini di servizio",
        "pt": "Você deve aceitar os termos de serviço",
        "ru": "Вы должны принять условия использования",
        "ar": "يجب عليك قبول شروط الخدمة",
        "ja": "利用規約に同意する必要があります",
        "ko": "서비스 약관에 동의해야 합니다",
        "zh": "您必须接受服务条款",
        "hi": "आपको सेवा की शर्तें स्वीकार करनी होंगी",
        "nl": "U moet de servicevoorwaarden accepteren",
        "pl": "Musisz zaakceptować regulamin",
        "sv": "Du måste acceptera användarvillkoren",
        "uk": "Ви повинні прийняти умови використання"
    },
    "register_success_title": {
        "tr": "Hesap Oluşturuldu", "en": "Account Created",
        "de": "Konto erstellt", "fr": "Compte créé",
        "es": "Cuenta creada", "it": "Account creato",
        "pt": "Conta criada", "ru": "Аккаунт создан",
        "ar": "تم إنشاء الحساب", "ja": "アカウント作成完了",
        "ko": "계정 생성됨", "zh": "账户已创建",
        "hi": "खाता बनाया गया", "nl": "Account aangemaakt",
        "pl": "Konto utworzone", "sv": "Konto skapat",
        "uk": "Обліковий запис створено"
    },
    "register_success_body": {
        "tr": "Hesabınız başarıyla oluşturuldu. Lütfen e-posta adresinizi onaylayın.",
        "en": "Your account has been created successfully. Please confirm your email address.",
        "de": "Ihr Konto wurde erfolgreich erstellt. Bitte bestätigen Sie Ihre E-Mail-Adresse.",
        "fr": "Votre compte a été créé avec succès. Veuillez confirmer votre adresse e-mail.",
        "es": "Su cuenta ha sido creada exitosamente. Por favor confirme su dirección de correo electrónico.",
        "it": "Il tuo account è stato creato con successo. Conferma il tuo indirizzo email.",
        "pt": "Sua conta foi criada com sucesso. Por favor confirme seu endereço de e-mail.",
        "ru": "Ваш аккаунт успешно создан. Пожалуйста, подтвердите ваш адрес электронной почты.",
        "ar": "تم إنشاء حسابك بنجاح. يرجى تأكيد عنوان بريدك الإلكتروني.",
        "ja": "アカウントが正常に作成されました。メールアドレスを確認してください。",
        "ko": "계정이 성공적으로 생성되었습니다. 이메일 주소를 확인해 주세요.",
        "zh": "您的账户已成功创建。请确认您的电子邮件地址。",
        "hi": "आपका खाता सफलतापूर्वक बनाया गया है। कृपया अपना ईमेल पता सत्यापित करें।",
        "nl": "Uw account is succesvol aangemaakt. Bevestig uw e-mailadres.",
        "pl": "Twoje konto zostało pomyślnie utworzone. Potwierdź swój adres e-mail.",
        "sv": "Ditt konto har skapats framgångsrikt. Vänligen bekräfta din e-postadress.",
        "uk": "Ваш обліковий запис успішно створено. Будь ласка, підтвердьте свою електронну адресу."
    },
    "ok": {
        "tr": "Tamam", "en": "OK", "de": "OK", "fr": "OK",
        "es": "Aceptar", "it": "OK", "pt": "OK",
        "ru": "ОК", "ar": "موافق", "ja": "OK", "ko": "확인",
        "zh": "确定", "hi": "ठीक है", "nl": "OK", "pl": "OK",
        "sv": "OK", "uk": "OK"
    },
    "email_already_registered": {
        "tr": "Bu e-posta adresi zaten kayıtlı.",
        "en": "This email is already registered.",
        "de": "Diese E-Mail-Adresse ist bereits registriert.",
        "fr": "Cette adresse e-mail est déjà enregistrée.",
        "es": "Este correo electrónico ya está registrado.",
        "it": "Questo indirizzo email è già registrato.",
        "pt": "Este endereço de e-mail já está registrado.",
        "ru": "Этот адрес электронной почты уже зарегистрирован.",
        "ar": "عنوان البريد الإلكتروني هذا مسجل بالفعل.",
        "ja": "このメールアドレスはすでに登録されています。",
        "ko": "이 이메일 주소는 이미 등록되어 있습니다.",
        "zh": "此电子邮件地址已被注册。",
        "hi": "यह ईमेल पता पहले से पंजीकृत है।",
        "nl": "Dit e-mailadres is al geregistreerd.",
        "pl": "Ten adres e-mail jest już zarejestrowany.",
        "sv": "Denna e-postadress är redan registrerad.",
        "uk": "Ця електронна адреса вже зареєстрована."
    },
    "register_failed_body": {
        "tr": "Kayıt yapılamadı. {{msg}}",
        "en": "Registration failed. {{msg}}",
        "de": "Registrierung fehlgeschlagen. {{msg}}",
        "fr": "Échec de l'inscription. {{msg}}",
        "es": "Error en el registro. {{msg}}",
        "it": "Registrazione non riuscita. {{msg}}",
        "pt": "Falha no registro. {{msg}}",
        "ru": "Ошибка регистрации. {{msg}}",
        "ar": "فشل التسجيل. {{msg}}",
        "ja": "登録に失敗しました。{{msg}}",
        "ko": "등록 실패. {{msg}}",
        "zh": "注册失败。{{msg}}",
        "hi": "पंजीकरण विफल। {{msg}}",
        "nl": "Registratie mislukt. {{msg}}",
        "pl": "Rejestracja nie powiodła się. {{msg}}",
        "sv": "Registreringen misslyckades. {{msg}}",
        "uk": "Помилка реєстрації. {{msg}}"
    },
    "already_have_account": {
        "tr": "Zaten hesabın var mı? ", "en": "Already have an account? ",
        "de": "Haben Sie bereits ein Konto? ", "fr": "Vous avez déjà un compte? ",
        "es": "¿Ya tienes una cuenta? ", "it": "Hai già un account? ",
        "pt": "Já tem uma conta? ", "ru": "Уже есть аккаунт? ",
        "ar": "هل لديك حساب بالفعل؟ ", "ja": "すでにアカウントをお持ちですか？ ",
        "ko": "이미 계정이 있으신가요? ", "zh": "已有账户？ ",
        "hi": "पहले से खाता है? ", "nl": "Heeft u al een account? ",
        "pl": "Masz już konto? ", "sv": "Har du redan ett konto? ",
        "uk": "Вже маєте обліковий запис? "
    },
    "strength_weak": {
        "tr": "Zayıf", "en": "Weak", "de": "Schwach", "fr": "Faible",
        "es": "Débil", "it": "Debole", "pt": "Fraca",
        "ru": "Слабый", "ar": "ضعيف", "ja": "弱い", "ko": "약함",
        "zh": "弱", "hi": "कमज़ोर", "nl": "Zwak", "pl": "Słabe",
        "sv": "Svagt", "uk": "Слабкий"
    },
    "strength_medium": {
        "tr": "Orta", "en": "Medium", "de": "Mittel", "fr": "Moyen",
        "es": "Medio", "it": "Medio", "pt": "Médio",
        "ru": "Средний", "ar": "متوسط", "ja": "普通", "ko": "보통",
        "zh": "中等", "hi": "मध्यम", "nl": "Gemiddeld", "pl": "Średnie",
        "sv": "Medel", "uk": "Середній"
    },
    "strength_strong": {
        "tr": "Güçlü", "en": "Strong", "de": "Stark", "fr": "Fort",
        "es": "Fuerte", "it": "Forte", "pt": "Forte",
        "ru": "Сильный", "ar": "قوي", "ja": "強い", "ko": "강함",
        "zh": "强", "hi": "मज़बूत", "nl": "Sterk", "pl": "Silne",
        "sv": "Starkt", "uk": "Сильний"
    },
}

all_langs = ["tr", "en", "de", "fr", "es", "it", "pt", "ru", "ar", "ja", "ko", "zh", "hi", "nl", "pl", "sv", "uk"]
base = "src/i18n"

for lang in all_langs:
    path = f"{base}/{lang}/common.json"
    with open(path, encoding="utf-8") as f:
        d = json.load(f)
    for key, translations in NEW_AUTH_KEYS.items():
        d["auth"][key] = translations[lang]
    with open(path, "w", encoding="utf-8") as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"Updated {lang}")

print("Done")
