-- Migration: 028_scenario_steps_part1.sql
-- Scenario steps for part 1 scenarios (achievement, anniversary, apology)
-- Auto-generated scenario steps

-- Scenario: Achievement Balloon Surprise (achievement-balloon-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2af32d0b-6d05-45c7-a427-a11dc138b9a3', 1, 'Balon Renkleri ve Teması Seçimi', 'Choose Balloon Colors and Theme', 'Kutlama temasına uygun balon renklerini ve şekillerini belirleyin.', 'Select balloon colors and shapes that match the celebration theme.', false, 7, 150),
(gen_random_uuid(), '2af32d0b-6d05-45c7-a427-a11dc138b9a3', 2, 'Balon ve Malzeme Tedariki', 'Procure Balloons and Supplies', 'Helyum balonları, kurdele ve dekorasyon malzemelerini satın alın.', 'Purchase helium balloons, ribbons, and decoration supplies.', false, 5, 300),
(gen_random_uuid(), '2af32d0b-6d05-45c7-a427-a11dc138b9a3', 3, 'Sürpriz Mekanını Hazırlama', 'Prepare the Surprise Venue', 'Balonları şişirin ve mekanı sürpriz için düzenleyin.', 'Inflate balloons and arrange the venue for the surprise.', false, 1, 0),
(gen_random_uuid(), '2af32d0b-6d05-45c7-a427-a11dc138b9a3', 4, 'Kişiselleştirilmiş Mesaj Kartları Ekleme', 'Add Personalized Message Cards', 'Her balona özel bir tebrik mesajı kartı bağlayın.', 'Attach a personalized congratulations card to each balloon.', true, 1, 50),
(gen_random_uuid(), '2af32d0b-6d05-45c7-a427-a11dc138b9a3', 5, 'Sürprizi Gerçekleştirme', 'Execute the Surprise', 'Kişi geldiğinde balonları serbest bırakın ve kutlamaya başlayın.', 'Release the balloons when the person arrives and start celebrating.', true, 0, 0);

-- Scenario: Achievement Cake Surprise (achievement-cake-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '758a180c-29dd-4519-8a55-b1decc5f3af9', 1, 'Pasta Tasarımı Planlama', 'Plan Cake Design', 'Başarıya özel pasta tasarımını ve mesajını belirleyin.', 'Decide on the cake design and message specific to the achievement.', false, 7, 0),
(gen_random_uuid(), '758a180c-29dd-4519-8a55-b1decc5f3af9', 2, 'Pastane Siparişi Verme', 'Place Bakery Order', 'Özel tasarım pastayı güvenilir bir pastaneden sipariş edin.', 'Order the custom-designed cake from a reliable bakery.', false, 5, 500),
(gen_random_uuid(), '758a180c-29dd-4519-8a55-b1decc5f3af9', 3, 'Kutlama Mekanını Hazırlama', 'Prepare Celebration Venue', 'Masayı, tabakları ve çatalları hazırlayın; mekanı süsleyin.', 'Set up the table, plates, and forks; decorate the venue.', false, 1, 100),
(gen_random_uuid(), '758a180c-29dd-4519-8a55-b1decc5f3af9', 4, 'Pasta Teslim Alımı', 'Pick Up the Cake', 'Pastayı teslim alın ve sürpriz anına kadar saklayın.', 'Pick up the cake and keep it hidden until the surprise moment.', false, 0, 0),
(gen_random_uuid(), '758a180c-29dd-4519-8a55-b1decc5f3af9', 5, 'Sürpriz Kutlama Anı', 'Surprise Celebration Moment', 'Pastayı çıkarın, mumları yakın ve hep birlikte kutlayın.', 'Reveal the cake, light the candles, and celebrate together.', true, 0, 0);

-- Scenario: Achievement Photo Wall (achievement-photo-wall)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6b7a27b6-3080-4afc-806e-55f696805c44', 1, 'Fotoğraf Seçimi ve Toplama', 'Select and Collect Photos', 'Başarı yolculuğunu anlatan en önemli fotoğrafları toplayın.', 'Collect the most significant photos that tell the achievement journey.', false, 10, 0),
(gen_random_uuid(), '6b7a27b6-3080-4afc-806e-55f696805c44', 2, 'Fotoğraf Baskı ve Çerçeveleme', 'Print and Frame Photos', 'Fotoğrafları bastırın ve uygun çerçeveler veya panolar hazırlayın.', 'Print the photos and prepare appropriate frames or boards.', false, 5, 400),
(gen_random_uuid(), '6b7a27b6-3080-4afc-806e-55f696805c44', 3, 'Duvar Düzeni Tasarlama', 'Design Wall Layout', 'Fotoğrafların duvar üzerindeki yerleşim düzenini planlayın.', 'Plan the arrangement of photos on the wall.', false, 3, 0),
(gen_random_uuid(), '6b7a27b6-3080-4afc-806e-55f696805c44', 4, 'Duvarı Hazırlama ve Asma', 'Prepare and Hang the Wall', 'Fotoğrafları duvara asın ve dekoratif öğeler ekleyin.', 'Hang the photos on the wall and add decorative elements.', false, 1, 100),
(gen_random_uuid(), '6b7a27b6-3080-4afc-806e-55f696805c44', 5, 'Açılış Anı Düzenleme', 'Organize Reveal Moment', 'Kişiyi fotoğraf duvarının önüne getirin ve tepkisini kaydedin.', 'Bring the person to the photo wall and record their reaction.', true, 0, 0);

-- Scenario: Achievement Podcast Episode (achievement-podcast-episode)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '41effc36-f22b-4f12-9d57-5592773d8963', 1, 'Podcast İçerik Planlaması', 'Plan Podcast Content', 'Bölümün konusunu, sorularını ve konuşmacılarını belirleyin.', 'Determine the episode topic, questions, and speakers.', false, 14, 0),
(gen_random_uuid(), '41effc36-f22b-4f12-9d57-5592773d8963', 2, 'Kayıt Ekipmanı Hazırlama', 'Prepare Recording Equipment', 'Mikrofon, kulaklık ve kayıt yazılımını hazırlayın ve test edin.', 'Set up and test the microphone, headphones, and recording software.', false, 7, 200),
(gen_random_uuid(), '41effc36-f22b-4f12-9d57-5592773d8963', 3, 'Podcast Bölümünü Kaydetme', 'Record the Podcast Episode', 'Başarı hikayesini anlatan özel bölümü kaydedin.', 'Record the special episode telling the achievement story.', false, 3, 0),
(gen_random_uuid(), '41effc36-f22b-4f12-9d57-5592773d8963', 4, 'Düzenleme ve Müzik Ekleme', 'Edit and Add Music', 'Kaydı düzenleyin, jingle ve arka plan müziği ekleyin.', 'Edit the recording, add jingles and background music.', true, 2, 0),
(gen_random_uuid(), '41effc36-f22b-4f12-9d57-5592773d8963', 5, 'Yayınlama ve Paylaşma', 'Publish and Share', 'Bölümü yayınlayın ve kişiyle özel bir şekilde paylaşın.', 'Publish the episode and share it with the person in a special way.', true, 0, 0);

-- Scenario: Achievement Time Capsule (achievement-time-capsule)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1a36f114-a149-43f9-ad5e-8fff137f95bf', 1, 'Zaman Kapsülü Kutusu Tedariki', 'Procure Time Capsule Box', 'Dayanıklı ve estetik bir zaman kapsülü kutusu satın alın.', 'Purchase a durable and aesthetic time capsule box.', false, 10, 200),
(gen_random_uuid(), '1a36f114-a149-43f9-ad5e-8fff137f95bf', 2, 'İçerik Toplama', 'Gather Contents', 'Fotoğraflar, mektuplar ve anı nesneleri gibi içerikleri toplayın.', 'Collect contents such as photos, letters, and memorabilia.', false, 7, 50),
(gen_random_uuid(), '1a36f114-a149-43f9-ad5e-8fff137f95bf', 3, 'Kişisel Mektup Yazma', 'Write Personal Letter', 'Gelecekte okunmak üzere duygusal bir mektup yazın.', 'Write an emotional letter to be read in the future.', false, 3, 0),
(gen_random_uuid(), '1a36f114-a149-43f9-ad5e-8fff137f95bf', 4, 'Kapsülü Hazırlama ve Mühürleme', 'Prepare and Seal the Capsule', 'Tüm içerikleri kapsüle yerleştirin ve tarihlendirerek mühürleyin.', 'Place all contents in the capsule, date it, and seal it.', true, 1, 0),
(gen_random_uuid(), '1a36f114-a149-43f9-ad5e-8fff137f95bf', 5, 'Tören ile Sunma', 'Present with Ceremony', 'Kapsülü özel bir törenle kişiye sunun ve açılış tarihini belirleyin.', 'Present the capsule in a special ceremony and set the opening date.', true, 0, 0);

-- Scenario: Achievement Surprise Video Call (achievement-video-call)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7329ee43-67cc-43cb-9f3e-7fa680caafca', 1, 'Katılımcı Listesi Oluşturma', 'Create Participant List', 'Sürpriz video görüşmesine katılacak kişilerin listesini hazırlayın.', 'Prepare the list of people who will join the surprise video call.', false, 10, 0),
(gen_random_uuid(), '7329ee43-67cc-43cb-9f3e-7fa680caafca', 2, 'Katılımcılarla Koordinasyon', 'Coordinate with Participants', 'Herkesle tarih ve saat konusunda anlaşın, bağlantı detaylarını paylaşın.', 'Agree on date and time with everyone, share connection details.', false, 7, 0),
(gen_random_uuid(), '7329ee43-67cc-43cb-9f3e-7fa680caafca', 3, 'Teknik Altyapı Testi', 'Test Technical Setup', 'Video konferans platformunu test edin ve yedek plan hazırlayın.', 'Test the video conferencing platform and prepare a backup plan.', false, 2, 0),
(gen_random_uuid(), '7329ee43-67cc-43cb-9f3e-7fa680caafca', 4, 'Sürpriz Senaryosu Hazırlama', 'Prepare Surprise Scenario', 'Görüşme akışını planlayın: açılış, konuşmalar ve kutlama anı.', 'Plan the call flow: opening, speeches, and celebration moment.', true, 1, 0),
(gen_random_uuid(), '7329ee43-67cc-43cb-9f3e-7fa680caafca', 5, 'Sürpriz Görüşmeyi Gerçekleştirme', 'Execute the Surprise Call', 'Kişiyi aramaya bağlayın ve sürpriz kutlamayı başlatın.', 'Connect the person to the call and start the surprise celebration.', true, 0, 0);

-- Scenario: Bucket List Board (bucket-list-board)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '08cb097e-1be2-428f-a4bb-254362c8d6a1', 1, 'Pano ve Malzeme Seçimi', 'Choose Board and Materials', 'Mantar pano veya beyaz tahta ve dekorasyon malzemeleri satın alın.', 'Purchase a cork board or whiteboard and decoration materials.', false, 7, 200),
(gen_random_uuid(), '08cb097e-1be2-428f-a4bb-254362c8d6a1', 2, 'Hayaller Listesi Araştırması', 'Research Bucket List Items', 'Kişinin hayallerini ve yapmak istediği şeyleri araştırın.', 'Research the person''''s dreams and things they want to do.', false, 5, 0),
(gen_random_uuid(), '08cb097e-1be2-428f-a4bb-254362c8d6a1', 3, 'Pano Tasarımı ve Düzenleme', 'Design and Arrange the Board', 'Kategorilere göre bölümler oluşturun ve görsel öğeler ekleyin.', 'Create sections by categories and add visual elements.', false, 3, 100),
(gen_random_uuid(), '08cb097e-1be2-428f-a4bb-254362c8d6a1', 4, 'Fotoğraf ve İlham Kartları Ekleme', 'Add Photos and Inspiration Cards', 'İlham verici görseller ve motivasyon kartları ekleyin.', 'Add inspiring images and motivation cards.', true, 1, 50),
(gen_random_uuid(), '08cb097e-1be2-428f-a4bb-254362c8d6a1', 5, 'Panoyu Hediye Etme', 'Gift the Board', 'Panoyu özel bir anda kişiye hediye edin ve birlikte gözden geçirin.', 'Gift the board at a special moment and review it together.', true, 0, 0);

-- Scenario: Career Milestone Dinner (career-milestone-dinner)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'cacbe77f-05b5-4871-a622-4e58ada52dba', 1, 'Restoran Araştırması ve Rezervasyon', 'Research and Reserve Restaurant', 'Özel bir restoran seçin ve tarihe uygun rezervasyon yapın.', 'Choose a special restaurant and make a reservation for the date.', false, 14, 0),
(gen_random_uuid(), 'cacbe77f-05b5-4871-a622-4e58ada52dba', 2, 'Davetli Listesi Hazırlama', 'Prepare Guest List', 'Kariyer yolculuğunda önemli olan kişilerin listesini oluşturun.', 'Create a list of people important in the career journey.', false, 10, 0),
(gen_random_uuid(), 'cacbe77f-05b5-4871-a622-4e58ada52dba', 3, 'Özel Menü ve Dekorasyon Planlama', 'Plan Special Menu and Decoration', 'Restoranla özel menü ve masa dekorasyonu konusunda anlaşın.', 'Arrange a special menu and table decoration with the restaurant.', false, 5, 500),
(gen_random_uuid(), 'cacbe77f-05b5-4871-a622-4e58ada52dba', 4, 'Konuşma ve Hediye Hazırlama', 'Prepare Speech and Gift', 'Kutlama konuşmanızı ve hatıra hediyesini hazırlayın.', 'Prepare your celebration speech and commemorative gift.', true, 2, 300),
(gen_random_uuid(), 'cacbe77f-05b5-4871-a622-4e58ada52dba', 5, 'Yemek Akşamını Gerçekleştirme', 'Host the Dinner Evening', 'Davetlileri karşılayın ve özel akşam yemeğinin tadını çıkarın.', 'Welcome guests and enjoy the special dinner evening.', true, 0, 0);

-- Scenario: Champagne Toast Surprise (champagne-toast-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '68d33767-01c8-40af-bb42-e77787525962', 1, 'Şampanya ve Kadeh Seçimi', 'Select Champagne and Glasses', 'Kaliteli bir şampanya ve şık kadehler seçin.', 'Choose a quality champagne and elegant glasses.', false, 7, 400),
(gen_random_uuid(), '68d33767-01c8-40af-bb42-e77787525962', 2, 'Kutlama Mekanı Belirleme', 'Determine Celebration Venue', 'Kutlama için uygun ve özel bir mekan belirleyin.', 'Identify a suitable and special venue for the celebration.', false, 5, 0),
(gen_random_uuid(), '68d33767-01c8-40af-bb42-e77787525962', 3, 'Mekan Dekorasyonu', 'Venue Decoration', 'Mekanı çiçekler, ışıklar ve kutlama süsleriyle donatın.', 'Decorate the venue with flowers, lights, and celebration ornaments.', false, 1, 300),
(gen_random_uuid(), '68d33767-01c8-40af-bb42-e77787525962', 4, 'Kadeh Kaldırma Konuşması Hazırlama', 'Prepare Toast Speech', 'Duygusal ve anlamlı bir kadeh kaldırma konuşması yazın.', 'Write an emotional and meaningful toast speech.', true, 1, 0),
(gen_random_uuid(), '68d33767-01c8-40af-bb42-e77787525962', 5, 'Kutlama Anı', 'Celebration Moment', 'Şampanyayı açın, kadeh kaldırın ve başarıyı kutlayın.', 'Pop the champagne, raise a toast, and celebrate the achievement.', true, 0, 0);

-- Scenario: Charity Donation Chain Celebration (charity-donation-chain)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2190d4b3-992a-40c5-b1fa-b88241195b4e', 1, 'Hayır Kurumu Araştırması', 'Research Charities', 'Kişinin değer verdiği konularda çalışan hayır kurumlarını araştırın.', 'Research charities working on causes the person values.', false, 10, 0),
(gen_random_uuid(), '2190d4b3-992a-40c5-b1fa-b88241195b4e', 2, 'Bağış Zinciri Planı Oluşturma', 'Create Donation Chain Plan', 'Kaç kişinin katılacağını ve bağış miktarlarını planlayın.', 'Plan how many people will participate and donation amounts.', false, 7, 0),
(gen_random_uuid(), '2190d4b3-992a-40c5-b1fa-b88241195b4e', 3, 'Katılımcıları Organize Etme', 'Organize Participants', 'Arkadaş ve aile üyelerini bağış zincirine davet edin.', 'Invite friends and family members to join the donation chain.', false, 5, 0),
(gen_random_uuid(), '2190d4b3-992a-40c5-b1fa-b88241195b4e', 4, 'Bağışları Gerçekleştirme', 'Execute Donations', 'Tüm katılımcıların bağışlarını yapmasını koordine edin.', 'Coordinate all participants to make their donations.', true, 1, 500),
(gen_random_uuid(), '2190d4b3-992a-40c5-b1fa-b88241195b4e', 5, 'Sertifika ve Kutlama Sunumu', 'Certificate and Celebration Presentation', 'Bağış sertifikalarını toplayın ve kutlama anında kişiye sunun.', 'Collect donation certificates and present them during the celebration.', true, 0, 50);

-- Scenario: Confetti Entrance Surprise (confetti-entrance-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5e24e447-d580-4e9d-876b-98ef67da4bd7', 1, 'Konfeti ve Malzeme Tedariki', 'Procure Confetti and Supplies', 'Renkli konfetiler, konfeti topları ve patlayan süsler satın alın.', 'Purchase colorful confetti, confetti cannons, and poppers.', false, 5, 200),
(gen_random_uuid(), '5e24e447-d580-4e9d-876b-98ef67da4bd7', 2, 'Giriş Noktası Planlaması', 'Plan Entry Point', 'Sürprizin gerçekleşeceği giriş noktasını ve zamanlamayı belirleyin.', 'Determine the entry point and timing for the surprise.', false, 3, 0),
(gen_random_uuid(), '5e24e447-d580-4e9d-876b-98ef67da4bd7', 3, 'Katılımcıları Bilgilendirme', 'Brief Participants', 'Sürprize katılacak kişileri bilgilendirin ve görevlerini belirleyin.', 'Inform surprise participants and assign their roles.', false, 2, 0),
(gen_random_uuid(), '5e24e447-d580-4e9d-876b-98ef67da4bd7', 4, 'Mekan Hazırlığı', 'Venue Preparation', 'Konfeti toplarını yerleştirin ve süsleme detaylarını tamamlayın.', 'Position confetti cannons and complete decoration details.', true, 0, 0),
(gen_random_uuid(), '5e24e447-d580-4e9d-876b-98ef67da4bd7', 5, 'Sürprizi Gerçekleştirme', 'Execute the Surprise', 'Kişi girdiğinde konfetileri patlatın ve coşkuyla karşılayın.', 'Pop the confetti when the person enters and greet them enthusiastically.', true, 0, 0);

-- Scenario: Custom Comic Achievement Story (custom-comic-achievement)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4a481177-cc86-445e-8470-374021791d1b', 1, 'Hikaye Senaryosu Yazma', 'Write Story Script', 'Başarı hikayesini çizgi roman formatında senaryolaştırın.', 'Script the achievement story in comic book format.', false, 14, 0),
(gen_random_uuid(), '4a481177-cc86-445e-8470-374021791d1b', 2, 'Çizer Bulma ve Anlaşma', 'Find and Hire an Artist', 'Profesyonel bir çizgi roman çizeri bulun ve anlaşma yapın.', 'Find a professional comic artist and make an agreement.', false, 10, 800),
(gen_random_uuid(), '4a481177-cc86-445e-8470-374021791d1b', 3, 'Karakter ve Sahne Onayı', 'Approve Characters and Scenes', 'Çizerin hazırladığı taslakları gözden geçirin ve onaylayın.', 'Review and approve the artist''''s drafts.', false, 5, 0),
(gen_random_uuid(), '4a481177-cc86-445e-8470-374021791d1b', 4, 'Baskı ve Ciltleme', 'Print and Bind', 'Tamamlanan çizgi romanı bastırın ve profesyonel şekilde ciltletin.', 'Print and professionally bind the completed comic.', true, 3, 300),
(gen_random_uuid(), '4a481177-cc86-445e-8470-374021791d1b', 5, 'Hediye Olarak Sunma', 'Present as Gift', 'Çizgi romanı özel bir kutuyla birlikte hediye edin.', 'Gift the comic along with a special box.', true, 0, 50);

-- Scenario: Custom Jersey Achievement Surprise (custom-jersey-achievement)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4c4e599c-0fb6-45ae-a97a-2e4caeb73925', 1, 'Forma Tasarımı Planlama', 'Plan Jersey Design', 'Forma rengini, numarasını ve üzerine yazılacak mesajı belirleyin.', 'Determine the jersey color, number, and message to be printed.', false, 10, 0),
(gen_random_uuid(), '4c4e599c-0fb6-45ae-a97a-2e4caeb73925', 2, 'Forma Siparişi Verme', 'Order the Jersey', 'Özel baskılı formayı güvenilir bir firmadan sipariş edin.', 'Order the custom-printed jersey from a reliable company.', false, 7, 350),
(gen_random_uuid(), '4c4e599c-0fb6-45ae-a97a-2e4caeb73925', 3, 'Hediye Paketi Hazırlama', 'Prepare Gift Package', 'Formayı özel bir kutu ve hediye paketiyle hazırlayın.', 'Prepare the jersey with a special box and gift wrapping.', false, 2, 50),
(gen_random_uuid(), '4c4e599c-0fb6-45ae-a97a-2e4caeb73925', 4, 'Sunum Anı Planlama', 'Plan Presentation Moment', 'Formanın sunulacağı anı ve ortamı planlayın.', 'Plan the moment and setting for presenting the jersey.', true, 1, 0),
(gen_random_uuid(), '4c4e599c-0fb6-45ae-a97a-2e4caeb73925', 5, 'Sürpriz Hediye Sunumu', 'Surprise Gift Presentation', 'Formayı sürpriz bir şekilde takdim edin ve giyilmiş fotoğraf çekin.', 'Present the jersey as a surprise and take photos while wearing it.', true, 0, 0);

-- Scenario: Custom Mug Celebration (custom-mug-celebration)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '28bb9041-18b9-45db-98ed-1cb1343e1b52', 1, 'Kupa Tasarımı Oluşturma', 'Create Mug Design', 'Kupanın üzerindeki fotoğraf, mesaj ve tasarımı belirleyin.', 'Determine the photo, message, and design on the mug.', false, 10, 0),
(gen_random_uuid(), '28bb9041-18b9-45db-98ed-1cb1343e1b52', 2, 'Kupa Siparişi Verme', 'Order the Mug', 'Özel baskılı kupayı sipariş edin.', 'Order the custom-printed mug.', false, 7, 100),
(gen_random_uuid(), '28bb9041-18b9-45db-98ed-1cb1343e1b52', 3, 'İçecek ve Sunum Hazırlığı', 'Prepare Beverage and Presentation', 'Kupayı özel bir içecekle doldurun ve sunum tepsisi hazırlayın.', 'Fill the mug with a special beverage and prepare a presentation tray.', false, 1, 50),
(gen_random_uuid(), '28bb9041-18b9-45db-98ed-1cb1343e1b52', 4, 'Hediye Kartı Yazma', 'Write Gift Card', 'Kupaya eşlik edecek kişisel bir mesaj kartı yazın.', 'Write a personal message card to accompany the mug.', true, 1, 20),
(gen_random_uuid(), '28bb9041-18b9-45db-98ed-1cb1343e1b52', 5, 'Kutlama Sunumu', 'Celebration Presentation', 'Kupayı sürpriz bir şekilde sunun ve kutlamaya başlayın.', 'Present the mug as a surprise and start celebrating.', true, 0, 0);

-- Scenario: Discovery Flight Experience (discovery-flight-experience)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '532a91d2-134c-4a04-801e-267c38bc72ce', 1, 'Uçuş Okulu Araştırması', 'Research Flight Schools', 'Keşif uçuşu sunan uçuş okullarını araştırın ve karşılaştırın.', 'Research and compare flight schools offering discovery flights.', false, 21, 0),
(gen_random_uuid(), '532a91d2-134c-4a04-801e-267c38bc72ce', 2, 'Uçuş Rezervasyonu Yapma', 'Book the Flight', 'Uygun tarih ve saatte keşif uçuşu rezervasyonu yapın.', 'Book the discovery flight for a suitable date and time.', false, 14, 2500),
(gen_random_uuid(), '532a91d2-134c-4a04-801e-267c38bc72ce', 3, 'Sürpriz Planı Hazırlama', 'Prepare Surprise Plan', 'Uçuş deneyimini nasıl sürpriz olarak açıklayacağınızı planlayın.', 'Plan how you will reveal the flight experience as a surprise.', false, 5, 0),
(gen_random_uuid(), '532a91d2-134c-4a04-801e-267c38bc72ce', 4, 'Ekipman ve Kıyafet Hazırlığı', 'Prepare Equipment and Clothing', 'Rahat kıyafetler ve gerekli belgeleri hazırlayın.', 'Prepare comfortable clothing and necessary documents.', true, 1, 0),
(gen_random_uuid(), '532a91d2-134c-4a04-801e-267c38bc72ce', 5, 'Uçuş Deneyimi Günü', 'Flight Experience Day', 'Uçuş okuluna gidin ve bu unutulmaz deneyimin tadını çıkarın.', 'Go to the flight school and enjoy this unforgettable experience.', true, 0, 0);

-- Scenario: Family Olympics Extravaganza (family-olympics)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1468c00c-935b-44d2-a71c-4eca59b6a501', 1, 'Yarışma Kategorileri Belirleme', 'Determine Competition Categories', 'Aile üyelerine uygun eğlenceli yarışma dallarını belirleyin.', 'Determine fun competition events suitable for family members.', false, 14, 0),
(gen_random_uuid(), '1468c00c-935b-44d2-a71c-4eca59b6a501', 2, 'Malzeme ve Ödül Tedariki', 'Procure Supplies and Prizes', 'Yarışma malzemelerini ve ödülleri (madalya, kupa) satın alın.', 'Purchase competition supplies and prizes (medals, trophies).', false, 7, 400),
(gen_random_uuid(), '1468c00c-935b-44d2-a71c-4eca59b6a501', 3, 'Mekan ve Parkur Hazırlığı', 'Prepare Venue and Course', 'Yarışma alanını hazırlayın ve parkurları kurun.', 'Prepare the competition area and set up courses.', false, 2, 100),
(gen_random_uuid(), '1468c00c-935b-44d2-a71c-4eca59b6a501', 4, 'Davet ve Takım Oluşturma', 'Invite and Form Teams', 'Aile üyelerini davet edin ve takımları oluşturun.', 'Invite family members and form teams.', true, 3, 0),
(gen_random_uuid(), '1468c00c-935b-44d2-a71c-4eca59b6a501', 5, 'Olimpiyat Günü', 'Olympics Day', 'Yarışmaları gerçekleştirin, ödülleri dağıtın ve kutlayın.', 'Hold the competitions, distribute prizes, and celebrate.', true, 0, 0);

-- Scenario: First Day Survival Kit (first-day-survival-kit)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '81d41bfe-9e4d-4394-b462-523014be0ca1', 1, 'Kit İçeriği Planlama', 'Plan Kit Contents', 'İlk güne özel ihtiyaç duyulacak eşyaların listesini çıkarın.', 'List items that will be needed for the first day.', false, 10, 0),
(gen_random_uuid(), '81d41bfe-9e4d-4394-b462-523014be0ca1', 2, 'Malzeme Satın Alma', 'Purchase Supplies', 'Listedeki tüm malzemeleri satın alın: not defteri, kalem, atıştırmalık vb.', 'Buy all items on the list: notebook, pen, snacks, etc.', false, 5, 300),
(gen_random_uuid(), '81d41bfe-9e4d-4394-b462-523014be0ca1', 3, 'Kit Kutusunu Hazırlama', 'Prepare the Kit Box', 'Kutuyu süsleyin ve malzemeleri düzenli şekilde yerleştirin.', 'Decorate the box and arrange supplies neatly inside.', false, 2, 50),
(gen_random_uuid(), '81d41bfe-9e4d-4394-b462-523014be0ca1', 4, 'Kişisel Mesaj ve İpuçları Ekleme', 'Add Personal Message and Tips', 'Motive edici bir mektup ve faydalı ipuçları kartı ekleyin.', 'Add a motivational letter and useful tips card.', true, 1, 0),
(gen_random_uuid(), '81d41bfe-9e4d-4394-b462-523014be0ca1', 5, 'Kiti Hediye Etme', 'Gift the Kit', 'Kiti ilk günün sabahında sürpriz olarak verin.', 'Give the kit as a surprise on the morning of the first day.', true, 0, 0);

-- Scenario: Framed Achievement Poster (framed-achievement-poster)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0b847847-ab58-4172-af7a-f3022fecdd40', 1, 'Poster Tasarımı Oluşturma', 'Create Poster Design', 'Başarıyı anlatan poster tasarımını ve içeriğini planlayın.', 'Plan the poster design and content that describes the achievement.', false, 10, 0),
(gen_random_uuid(), '0b847847-ab58-4172-af7a-f3022fecdd40', 2, 'Grafik Tasarım Hazırlığı', 'Prepare Graphic Design', 'Profesyonel bir tasarım programıyla posteri hazırlayın veya tasarımcıya yaptırın.', 'Create the poster with a professional design tool or hire a designer.', false, 7, 300),
(gen_random_uuid(), '0b847847-ab58-4172-af7a-f3022fecdd40', 3, 'Baskı ve Çerçeveleme', 'Print and Frame', 'Posteri yüksek kalitede bastırın ve şık bir çerçeveye koyun.', 'Print the poster in high quality and place it in an elegant frame.', false, 3, 250),
(gen_random_uuid(), '0b847847-ab58-4172-af7a-f3022fecdd40', 4, 'Hediye Paketi Hazırlama', 'Prepare Gift Wrapping', 'Çerçeveli posteri özel bir hediye paketiyle sarın.', 'Wrap the framed poster with special gift wrapping.', true, 1, 30),
(gen_random_uuid(), '0b847847-ab58-4172-af7a-f3022fecdd40', 5, 'Sunma ve Asma', 'Present and Hang', 'Posteri hediye edin ve birlikte duvara asın.', 'Gift the poster and hang it on the wall together.', true, 0, 0);

-- Scenario: Hall of Fame Desk (hall-of-fame-desk)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '568604eb-ad17-4114-bda1-50d7e854b55a', 1, 'Masa Düzeni Konsepti Belirleme', 'Determine Desk Layout Concept', 'Şöhret salonu temalı masa düzeni konseptini planlayın.', 'Plan the hall of fame themed desk layout concept.', false, 10, 0),
(gen_random_uuid(), '568604eb-ad17-4114-bda1-50d7e854b55a', 2, 'Dekorasyon Malzemeleri Tedariki', 'Procure Decoration Materials', 'Mini kupa, çerçeve, isimlik ve plaket gibi malzemeler satın alın.', 'Purchase items like mini trophies, frames, nameplates, and plaques.', false, 7, 500),
(gen_random_uuid(), '568604eb-ad17-4114-bda1-50d7e854b55a', 3, 'Kişiselleştirilmiş Öğeler Hazırlama', 'Prepare Personalized Items', 'İsim plakası ve başarı sertifikalarını hazırlatın.', 'Have the nameplate and achievement certificates prepared.', false, 3, 200),
(gen_random_uuid(), '568604eb-ad17-4114-bda1-50d7e854b55a', 4, 'Masayı Düzenleme', 'Arrange the Desk', 'Tüm öğeleri masaya yerleştirin ve düzeni tamamlayın.', 'Place all items on the desk and complete the arrangement.', true, 0, 0),
(gen_random_uuid(), '568604eb-ad17-4114-bda1-50d7e854b55a', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Kişiyi masasına yönlendirin ve şöhret salonu sürprizini gösterin.', 'Guide the person to their desk and reveal the hall of fame surprise.', true, 0, 0);

-- Scenario: Homecoming Feast and Memory Wall (homecoming-feast)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2b955a0b-ebbf-4573-8955-a4fc003aafd0', 1, 'Menü Planlama', 'Plan the Menu', 'Kişinin en sevdiği yemeklerden oluşan bir menü hazırlayın.', 'Create a menu consisting of the person''''s favorite dishes.', false, 7, 0),
(gen_random_uuid(), '2b955a0b-ebbf-4573-8955-a4fc003aafd0', 2, 'Malzeme ve Market Alışverişi', 'Grocery Shopping', 'Menüdeki tüm yemekler için gerekli malzemeleri satın alın.', 'Purchase all necessary ingredients for the menu items.', false, 3, 500),
(gen_random_uuid(), '2b955a0b-ebbf-4573-8955-a4fc003aafd0', 3, 'Anı Duvarı Hazırlama', 'Prepare Memory Wall', 'Fotoğraflar ve mesajlarla anı duvarını hazırlayın.', 'Prepare the memory wall with photos and messages.', false, 2, 100),
(gen_random_uuid(), '2b955a0b-ebbf-4573-8955-a4fc003aafd0', 4, 'Yemek Pişirme ve Mekan Hazırlığı', 'Cook and Prepare Venue', 'Yemekleri pişirin, masayı kurun ve mekanı süsleyin.', 'Cook the dishes, set the table, and decorate the venue.', false, 0, 0),
(gen_random_uuid(), '2b955a0b-ebbf-4573-8955-a4fc003aafd0', 5, 'Hoş Geldin Kutlaması', 'Welcome Celebration', 'Kişiyi kapıda karşılayın ve ziyafet ile anı duvarını gösterin.', 'Greet the person at the door and show the feast and memory wall.', true, 0, 0);

-- Scenario: Office Desk Decoration Surprise (office-desk-decoration)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f230764b-a9da-4dbc-924f-1bf583560ed0', 1, 'Dekorasyon Teması Seçimi', 'Choose Decoration Theme', 'Ofis ortamına uygun bir kutlama dekorasyon teması belirleyin.', 'Choose a celebration decoration theme suitable for the office.', false, 5, 0),
(gen_random_uuid(), 'f230764b-a9da-4dbc-924f-1bf583560ed0', 2, 'Süsleme Malzemeleri Tedariki', 'Procure Decoration Supplies', 'Balon, afiş, konfeti ve masa süsleri satın alın.', 'Purchase balloons, banners, confetti, and desk decorations.', false, 3, 200),
(gen_random_uuid(), 'f230764b-a9da-4dbc-924f-1bf583560ed0', 3, 'İş Arkadaşlarıyla Koordinasyon', 'Coordinate with Colleagues', 'İş arkadaşlarını bilgilendirin ve görev dağılımı yapın.', 'Inform colleagues and distribute tasks.', false, 2, 0),
(gen_random_uuid(), 'f230764b-a9da-4dbc-924f-1bf583560ed0', 4, 'Masayı Süsleme', 'Decorate the Desk', 'Kişi gelmeden önce masasını balonlar ve süslerle donatın.', 'Decorate the desk with balloons and ornaments before the person arrives.', false, 0, 0),
(gen_random_uuid(), 'f230764b-a9da-4dbc-924f-1bf583560ed0', 5, 'Sürpriz Karşılama', 'Surprise Welcome', 'Kişi ofise geldiğinde tüm ekiple birlikte sürpriz yapın.', 'Surprise the person together with the whole team when they arrive.', true, 0, 0);

-- Scenario: Personalized Nameplate (personalized-nameplate)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6f5e54cd-e002-409b-b212-c8ff277c922c', 1, 'İsim Plakası Tasarımı', 'Nameplate Design', 'Plaka malzemesini, yazı tipini ve üzerine yazılacak metni belirleyin.', 'Determine the plaque material, font, and text to be engraved.', false, 14, 0),
(gen_random_uuid(), '6f5e54cd-e002-409b-b212-c8ff277c922c', 2, 'Sipariş Verme', 'Place Order', 'Özel isim plakasını güvenilir bir atölyeden sipariş edin.', 'Order the personalized nameplate from a reliable workshop.', false, 10, 300),
(gen_random_uuid(), '6f5e54cd-e002-409b-b212-c8ff277c922c', 3, 'Kalite Kontrolü', 'Quality Check', 'Teslim alınan plakayı kontrol edin, yazım hatası olmadığından emin olun.', 'Check the delivered plaque and ensure there are no spelling errors.', false, 3, 0),
(gen_random_uuid(), '6f5e54cd-e002-409b-b212-c8ff277c922c', 4, 'Hediye Paketi Hazırlama', 'Prepare Gift Wrapping', 'Plakayı özel bir kutuda hediye olarak paketleyin.', 'Package the plaque as a gift in a special box.', true, 1, 30),
(gen_random_uuid(), '6f5e54cd-e002-409b-b212-c8ff277c922c', 5, 'Sunma ve Yerleştirme', 'Present and Install', 'Plakayı hediye edin ve birlikte masaya veya kapıya yerleştirin.', 'Gift the plaque and install it on the desk or door together.', true, 0, 0);

-- Scenario: Photo Mosaic Achievement Surprise (photo-mosaic-achievement)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'cc5eeff3-fc8a-4610-a1d0-2e923b565577', 1, 'Fotoğraf Toplama', 'Collect Photos', 'Mozaik için kullanılacak yüzlerce fotoğrafı toplayın.', 'Collect hundreds of photos to be used for the mosaic.', false, 14, 0),
(gen_random_uuid(), 'cc5eeff3-fc8a-4610-a1d0-2e923b565577', 2, 'Ana Görsel Seçimi', 'Select Main Image', 'Mozaiğin oluşturacağı ana başarı görselini seçin.', 'Choose the main achievement image the mosaic will form.', false, 10, 0),
(gen_random_uuid(), 'cc5eeff3-fc8a-4610-a1d0-2e923b565577', 3, 'Mozaik Tasarımı ve Üretimi', 'Design and Produce Mosaic', 'Profesyonel mozaik yazılımıyla tasarımı yapın veya yaptırın.', 'Create the design with professional mosaic software or have it done.', false, 7, 500),
(gen_random_uuid(), 'cc5eeff3-fc8a-4610-a1d0-2e923b565577', 4, 'Baskı ve Çerçeveleme', 'Print and Frame', 'Mozaiği büyük formatta bastırın ve çerçeveletin.', 'Print the mosaic in large format and have it framed.', true, 3, 400),
(gen_random_uuid(), 'cc5eeff3-fc8a-4610-a1d0-2e923b565577', 5, 'Sürpriz Sunum', 'Surprise Presentation', 'Fotoğraf mozaiğini sürpriz bir şekilde kişiye gösterin.', 'Reveal the photo mosaic to the person as a surprise.', true, 0, 0);

-- Scenario: Promotion Picnic Celebration (promotion-picnic-celebration)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6518954d-fdfb-4db0-9082-f6cd465def94', 1, 'Piknik Mekanı Seçimi', 'Choose Picnic Venue', 'Doğada güzel ve uygun bir piknik alanı belirleyin.', 'Find a beautiful and suitable picnic area in nature.', false, 10, 0),
(gen_random_uuid(), '6518954d-fdfb-4db0-9082-f6cd465def94', 2, 'Yiyecek ve İçecek Hazırlığı', 'Prepare Food and Drinks', 'Piknik sepetini leziz yiyecekler ve içeceklerle doldurun.', 'Fill the picnic basket with delicious food and beverages.', false, 3, 400),
(gen_random_uuid(), '6518954d-fdfb-4db0-9082-f6cd465def94', 3, 'Piknik Ekipmanı Hazırlama', 'Prepare Picnic Equipment', 'Battaniye, tabak, bardak ve masa örtüsünü hazırlayın.', 'Prepare the blanket, plates, cups, and tablecloth.', false, 2, 100),
(gen_random_uuid(), '6518954d-fdfb-4db0-9082-f6cd465def94', 4, 'Kutlama Süsleri Ekleme', 'Add Celebration Decorations', 'Terfi temalı afiş, balon ve konfeti gibi süsler ekleyin.', 'Add promotion-themed decorations like banners, balloons, and confetti.', true, 1, 100),
(gen_random_uuid(), '6518954d-fdfb-4db0-9082-f6cd465def94', 5, 'Piknik Kutlaması', 'Picnic Celebration', 'Doğada keyifli bir piknik yaparak terfiyi kutlayın.', 'Celebrate the promotion with an enjoyable picnic in nature.', true, 0, 0);

-- Scenario: Retirement Bucket List Party (retirement-bucket-list)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1e78d31d-4371-4fb2-ab05-389a3a7e4024', 1, 'Emeklilik Hayalleri Araştırması', 'Research Retirement Dreams', 'Emekli olacak kişinin hayallerini ve isteklerini araştırın.', 'Research the retiring person''''s dreams and desires.', false, 14, 0),
(gen_random_uuid(), '1e78d31d-4371-4fb2-ab05-389a3a7e4024', 2, 'Kova Listesi Panosu Hazırlama', 'Prepare Bucket List Board', 'Büyük bir pano üzerine emeklilik hayallerini görsel olarak yerleştirin.', 'Visually arrange retirement dreams on a large board.', false, 7, 200),
(gen_random_uuid(), '1e78d31d-4371-4fb2-ab05-389a3a7e4024', 3, 'Parti Mekanı ve Dekorasyon', 'Party Venue and Decoration', 'Parti mekanını emeklilik temasıyla süsleyin.', 'Decorate the party venue with a retirement theme.', false, 3, 500),
(gen_random_uuid(), '1e78d31d-4371-4fb2-ab05-389a3a7e4024', 4, 'Hediye ve Sürpriz Hazırlığı', 'Prepare Gifts and Surprises', 'Listedeki ilk maddeyi gerçekleştirecek bir hediye hazırlayın.', 'Prepare a gift that will fulfill the first item on the list.', true, 2, 500),
(gen_random_uuid(), '1e78d31d-4371-4fb2-ab05-389a3a7e4024', 5, 'Parti Günü', 'Party Day', 'Partiyi düzenleyin, listeyi açıklayın ve birlikte kutlayın.', 'Host the party, reveal the list, and celebrate together.', true, 0, 0);

-- Scenario: Retirement Smash the Clock Fiesta (retirement-smash-clock)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b7f6c45b-6811-435b-8842-b8ae5a29e1fe', 1, 'Eski Saat Tedariki', 'Procure Old Clock', 'Kırılacak eski bir duvar saati veya çalar saat bulun.', 'Find an old wall clock or alarm clock to be smashed.', false, 10, 50),
(gen_random_uuid(), 'b7f6c45b-6811-435b-8842-b8ae5a29e1fe', 2, 'Fiesta Malzemeleri Hazırlama', 'Prepare Fiesta Supplies', 'Parti malzemeleri, konfeti, müzik sistemi ve güvenlik ekipmanı alın.', 'Get party supplies, confetti, sound system, and safety equipment.', false, 5, 300),
(gen_random_uuid(), 'b7f6c45b-6811-435b-8842-b8ae5a29e1fe', 3, 'Mekan Hazırlığı', 'Prepare Venue', 'Saat kırma alanını güvenli bir şekilde hazırlayın ve süsleyin.', 'Safely prepare and decorate the clock-smashing area.', false, 2, 100),
(gen_random_uuid(), 'b7f6c45b-6811-435b-8842-b8ae5a29e1fe', 4, 'Davetlileri Organize Etme', 'Organize Guests', 'Emeklilik kutlamasına gelecek kişileri davet edin ve koordine edin.', 'Invite and coordinate people coming to the retirement celebration.', true, 3, 0),
(gen_random_uuid(), 'b7f6c45b-6811-435b-8842-b8ae5a29e1fe', 5, 'Saat Kırma Töreni', 'Clock Smashing Ceremony', 'Saati kırma törenini gerçekleştirin ve coşkuyla kutlayın.', 'Hold the clock smashing ceremony and celebrate enthusiastically.', true, 0, 0);

-- Scenario: Retirement Video Montage (retirement-video-montage)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4f65335a-f019-494e-88a4-0e684c2d508b', 1, 'Video Materyalleri Toplama', 'Collect Video Materials', 'İş arkadaşları ve aileden video mesajlar ve fotoğraflar toplayın.', 'Collect video messages and photos from colleagues and family.', false, 21, 0),
(gen_random_uuid(), '4f65335a-f019-494e-88a4-0e684c2d508b', 2, 'Senaryo ve Akış Planlama', 'Plan Script and Flow', 'Video montajın akışını ve bölümlerini planlayın.', 'Plan the flow and sections of the video montage.', false, 14, 0),
(gen_random_uuid(), '4f65335a-f019-494e-88a4-0e684c2d508b', 3, 'Video Düzenleme', 'Video Editing', 'Toplanan materyalleri profesyonel bir video düzenleme programıyla birleştirin.', 'Combine collected materials with a professional video editing program.', false, 7, 500),
(gen_random_uuid(), '4f65335a-f019-494e-88a4-0e684c2d508b', 4, 'Müzik ve Efekt Ekleme', 'Add Music and Effects', 'Duygusal müzik ve geçiş efektleri ekleyin.', 'Add emotional music and transition effects.', true, 3, 0),
(gen_random_uuid(), '4f65335a-f019-494e-88a4-0e684c2d508b', 5, 'Gösterim Organizasyonu', 'Screening Organization', 'Videoyu emeklilik töreninde büyük ekranda gösterin.', 'Screen the video on a big screen at the retirement ceremony.', true, 0, 100);

-- Scenario: Rooftop Achievement Party (rooftop-party-achievement)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1561ec99-be43-47bd-8f27-bd570dfd2118', 1, 'Çatı Katı Mekanı Ayarlama', 'Arrange Rooftop Venue', 'Uygun bir çatı katı mekanı bulun ve rezervasyon yapın.', 'Find a suitable rooftop venue and make a reservation.', false, 14, 1000),
(gen_random_uuid(), '1561ec99-be43-47bd-8f27-bd570dfd2118', 2, 'Yiyecek ve İçecek Planlaması', 'Plan Food and Drinks', 'Parti için menüyü hazırlayın ve ikram siparişi verin.', 'Prepare the menu for the party and order catering.', false, 7, 1500),
(gen_random_uuid(), '1561ec99-be43-47bd-8f27-bd570dfd2118', 3, 'Dekorasyon ve Müzik Hazırlığı', 'Prepare Decoration and Music', 'Mekanı süsleyin ve müzik sistemi kurun veya DJ ayarlayın.', 'Decorate the venue and set up a sound system or arrange a DJ.', false, 3, 500),
(gen_random_uuid(), '1561ec99-be43-47bd-8f27-bd570dfd2118', 4, 'Davetiye Gönderme', 'Send Invitations', 'Davetlilere özel davetiye gönderin ve katılımları onaylayın.', 'Send special invitations to guests and confirm attendance.', true, 5, 50),
(gen_random_uuid(), '1561ec99-be43-47bd-8f27-bd570dfd2118', 5, 'Parti Gecesi', 'Party Night', 'Çatı katında muhteşem bir başarı partisi düzenleyin.', 'Host an amazing achievement party on the rooftop.', true, 0, 0);

-- Scenario: Scratch-Off Adventure Map (scratch-off-adventure-map)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6b4b3e48-b6d5-4b9e-953c-6939ead6f4a7', 1, 'Kazı Kazan Harita Seçimi', 'Choose Scratch-Off Map', 'Kaliteli ve detaylı bir kazı kazan dünya haritası satın alın.', 'Purchase a quality and detailed scratch-off world map.', false, 7, 200),
(gen_random_uuid(), '6b4b3e48-b6d5-4b9e-953c-6939ead6f4a7', 2, 'Ziyaret Edilen Yerler Araştırması', 'Research Visited Places', 'Kişinin daha önce ziyaret ettiği yerleri araştırın.', 'Research places the person has previously visited.', false, 5, 0),
(gen_random_uuid(), '6b4b3e48-b6d5-4b9e-953c-6939ead6f4a7', 3, 'Harita Çerçeveleme', 'Frame the Map', 'Haritayı şık bir çerçeveye koyun ve duvara asılmaya hazırlayın.', 'Put the map in an elegant frame and prepare it for hanging.', false, 3, 200),
(gen_random_uuid(), '6b4b3e48-b6d5-4b9e-953c-6939ead6f4a7', 4, 'İlk Kazıma Seti Hazırlama', 'Prepare First Scratch Set', 'Ziyaret edilen yerler için kazıma aracı ve bir not kartı hazırlayın.', 'Prepare a scratching tool and a note card for visited places.', true, 1, 20),
(gen_random_uuid(), '6b4b3e48-b6d5-4b9e-953c-6939ead6f4a7', 5, 'Hediye Sunumu', 'Gift Presentation', 'Haritayı hediye edin ve birlikte ilk yerleri kazıyın.', 'Gift the map and scratch the first places together.', true, 0, 0);

-- Scenario: Secret Supper Club Celebration (secret-supper-club)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd4053a58-04a4-4b1f-a7ba-ccb09b65e5b0', 1, 'Gizli Yemek Konsepti Belirleme', 'Determine Secret Supper Concept', 'Yemeğin temasını, mutfak türünü ve gizli mekanı belirleyin.', 'Determine the dinner''''s theme, cuisine type, and secret location.', false, 14, 0),
(gen_random_uuid(), 'd4053a58-04a4-4b1f-a7ba-ccb09b65e5b0', 2, 'Şef veya Aşçı Ayarlama', 'Arrange Chef or Cook', 'Profesyonel bir şef tutun veya yemeği kendiniz pişirmeyi planlayın.', 'Hire a professional chef or plan to cook the meal yourself.', false, 10, 1000),
(gen_random_uuid(), 'd4053a58-04a4-4b1f-a7ba-ccb09b65e5b0', 3, 'Mekan Hazırlığı ve Dekorasyon', 'Venue Preparation and Decoration', 'Gizli mekanı atmosferik bir şekilde süsleyin.', 'Decorate the secret venue atmospherically.', false, 3, 500),
(gen_random_uuid(), 'd4053a58-04a4-4b1f-a7ba-ccb09b65e5b0', 4, 'Davetiye ve İpuçları Gönderme', 'Send Invitations and Clues', 'Davetlilere gizemli davetiyeler ve mekan ipuçları gönderin.', 'Send mysterious invitations and venue clues to guests.', true, 5, 50),
(gen_random_uuid(), 'd4053a58-04a4-4b1f-a7ba-ccb09b65e5b0', 5, 'Gizli Yemek Gecesi', 'Secret Supper Night', 'Gizli yemek kulübü gecesini gerçekleştirin ve kutlayın.', 'Host the secret supper club night and celebrate.', true, 0, 0);

-- Scenario: Standing Ovation Surprise (standing-ovation-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b5ae223d-967d-4b01-9f3b-5b1cbb432adc', 1, 'Katılımcı Grubu Oluşturma', 'Form Participant Group', 'Ayakta alkış yapacak kişileri belirleyin ve organize edin.', 'Identify and organize people who will give the standing ovation.', false, 7, 0),
(gen_random_uuid(), 'b5ae223d-967d-4b01-9f3b-5b1cbb432adc', 2, 'Senaryo ve Zamanlama Planı', 'Plan Script and Timing', 'Ayakta alkışın tam zamanını ve senaryosunu planlayın.', 'Plan the exact timing and scenario of the standing ovation.', false, 5, 0),
(gen_random_uuid(), 'b5ae223d-967d-4b01-9f3b-5b1cbb432adc', 3, 'Mekan Hazırlığı', 'Prepare Venue', 'Alkışın gerçekleşeceği mekanı hazırlayın ve katılımcıları yerleştirin.', 'Prepare the venue and position the participants.', false, 1, 0),
(gen_random_uuid(), 'b5ae223d-967d-4b01-9f3b-5b1cbb432adc', 4, 'Prova Yapma', 'Conduct Rehearsal', 'Katılımcılarla kısa bir prova yapın ve sinyalleri belirleyin.', 'Conduct a brief rehearsal with participants and determine signals.', true, 1, 0),
(gen_random_uuid(), 'b5ae223d-967d-4b01-9f3b-5b1cbb432adc', 5, 'Ayakta Alkış Anı', 'Standing Ovation Moment', 'Kişi geldiğinde hep birlikte ayağa kalkın ve coşkuyla alkışlayın.', 'Stand up together when the person arrives and applaud enthusiastically.', true, 0, 0);

-- Scenario: Surprise Bonus Trip (surprise-bonus-trip)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'af484eb4-d918-4f67-9cd0-9854562d5345', 1, 'Seyahat Destinasyonu Seçimi', 'Choose Travel Destination', 'Kişinin hayalindeki veya ilgisini çekecek bir destinasyon seçin.', 'Choose a destination the person dreams of or would find interesting.', false, 30, 0),
(gen_random_uuid(), 'af484eb4-d918-4f67-9cd0-9854562d5345', 2, 'Uçak ve Otel Rezervasyonu', 'Book Flights and Hotel', 'Uçak biletlerini ve oteli en uygun fiyatlarla rezerve edin.', 'Book flight tickets and hotel at the best prices.', false, 21, 5000),
(gen_random_uuid(), 'af484eb4-d918-4f67-9cd0-9854562d5345', 3, 'Gezi Planı Hazırlama', 'Prepare Trip Itinerary', 'Gezilecek yerler, aktiviteler ve restoran listesi oluşturun.', 'Create a list of places to visit, activities, and restaurants.', false, 10, 0),
(gen_random_uuid(), 'af484eb4-d918-4f67-9cd0-9854562d5345', 4, 'Sürpriz Açıklama Planı', 'Plan Surprise Reveal', 'Seyahati nasıl sürpriz olarak açıklayacağınızı planlayın.', 'Plan how you will reveal the trip as a surprise.', true, 3, 50),
(gen_random_uuid(), 'af484eb4-d918-4f67-9cd0-9854562d5345', 5, 'Sürpriz Açıklama Anı', 'Surprise Reveal Moment', 'Biletleri ve planı sürpriz bir şekilde gösterin.', 'Reveal the tickets and plan as a surprise.', true, 0, 0);

-- Scenario: Achievement Surprise Party (surprise-party-achievement)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b9ddd08f-c760-4143-912b-8bab6fbac054', 1, 'Parti Planı ve Davetli Listesi', 'Party Plan and Guest List', 'Parti konseptini belirleyin ve davetli listesini oluşturun.', 'Determine the party concept and create the guest list.', false, 14, 0),
(gen_random_uuid(), 'b9ddd08f-c760-4143-912b-8bab6fbac054', 2, 'Mekan ve İkram Ayarlama', 'Arrange Venue and Catering', 'Parti mekanını ayarlayın ve yiyecek-içecek siparişi verin.', 'Arrange the party venue and order food and drinks.', false, 7, 2000),
(gen_random_uuid(), 'b9ddd08f-c760-4143-912b-8bab6fbac054', 3, 'Dekorasyon Hazırlığı', 'Prepare Decorations', 'Başarı temalı süslemeler, afişler ve balonlar hazırlayın.', 'Prepare achievement-themed decorations, banners, and balloons.', false, 3, 300),
(gen_random_uuid(), 'b9ddd08f-c760-4143-912b-8bab6fbac054', 4, 'Sürpriz Senaryosu ve Koordinasyon', 'Surprise Scenario and Coordination', 'Kişinin partiye nasıl getirileceğini planlayın ve herkesi koordine edin.', 'Plan how to bring the person to the party and coordinate everyone.', true, 2, 0),
(gen_random_uuid(), 'b9ddd08f-c760-4143-912b-8bab6fbac054', 5, 'Sürpriz Parti', 'Surprise Party', 'Kişi geldiğinde hep birlikte sürpriz yapın ve kutlamaya başlayın.', 'Surprise the person together when they arrive and start celebrating.', true, 0, 0);

-- Scenario: Team Celebration Lunch (team-celebration-lunch)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '315867b5-0cb4-4efd-b928-043ce6188dc9', 1, 'Restoran Seçimi ve Rezervasyon', 'Choose Restaurant and Reserve', 'Ekip için uygun bir restoran seçin ve tarihte rezervasyon yapın.', 'Choose a suitable restaurant for the team and reserve for the date.', false, 10, 0),
(gen_random_uuid(), '315867b5-0cb4-4efd-b928-043ce6188dc9', 2, 'Menü Planlaması', 'Plan the Menu', 'Herkesin tercihlerini göz önünde bulundurarak menüyü belirleyin.', 'Determine the menu considering everyone''''s preferences.', false, 5, 0),
(gen_random_uuid(), '315867b5-0cb4-4efd-b928-043ce6188dc9', 3, 'Kutlama Malzemeleri Hazırlama', 'Prepare Celebration Materials', 'Tebrik kartı, küçük hediyeler ve masa süsleri hazırlayın.', 'Prepare congratulations cards, small gifts, and table decorations.', false, 3, 200),
(gen_random_uuid(), '315867b5-0cb4-4efd-b928-043ce6188dc9', 4, 'Ekibi Bilgilendirme', 'Brief the Team', 'Ekip üyelerini tarih ve saat konusunda bilgilendirin.', 'Inform team members about the date and time.', true, 3, 0),
(gen_random_uuid(), '315867b5-0cb4-4efd-b928-043ce6188dc9', 5, 'Kutlama Öğle Yemeği', 'Celebration Lunch', 'Ekiple birlikte öğle yemeğinde başarıyı kutlayın.', 'Celebrate the achievement with the team at lunch.', true, 0, 1500);

-- Scenario: Trophy Ceremony Surprise (trophy-ceremony-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'faa45c99-887b-4db0-903b-ed09b00486b9', 1, 'Kupa veya Ödül Tasarımı', 'Design Trophy or Award', 'Özel bir kupa veya ödül plaketi tasarlayın ve sipariş edin.', 'Design and order a custom trophy or award plaque.', false, 14, 400),
(gen_random_uuid(), 'faa45c99-887b-4db0-903b-ed09b00486b9', 2, 'Tören Senaryosu Hazırlama', 'Prepare Ceremony Script', 'Ödül töreni için konuşma ve senaryo hazırlayın.', 'Prepare a speech and script for the award ceremony.', false, 7, 0),
(gen_random_uuid(), 'faa45c99-887b-4db0-903b-ed09b00486b9', 3, 'Mekan ve Sahne Düzeni', 'Venue and Stage Setup', 'Tören mekanını hazırlayın ve sahne düzenini kurun.', 'Prepare the ceremony venue and set up the stage.', false, 2, 300),
(gen_random_uuid(), 'faa45c99-887b-4db0-903b-ed09b00486b9', 4, 'Katılımcıları Davet Etme', 'Invite Participants', 'Törene katılacak kişileri davet edin ve provasını yapın.', 'Invite participants to the ceremony and conduct a rehearsal.', true, 3, 0),
(gen_random_uuid(), 'faa45c99-887b-4db0-903b-ed09b00486b9', 5, 'Ödül Töreni', 'Award Ceremony', 'Ödül törenini gerçekleştirin ve kupayı takdim edin.', 'Hold the award ceremony and present the trophy.', true, 0, 0);

-- Scenario: Wish Tree Celebration (wish-tree-celebration)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a58e8489-23c4-45ba-9e8e-f3e60745a3cb', 1, 'Dilek Ağacı Malzemeleri Tedariki', 'Procure Wish Tree Materials', 'Dekoratif bir ağaç dalı, saksı ve dilek kartları satın alın.', 'Purchase a decorative tree branch, pot, and wish cards.', false, 7, 200),
(gen_random_uuid(), 'a58e8489-23c4-45ba-9e8e-f3e60745a3cb', 2, 'Ağacı Hazırlama ve Süsleme', 'Prepare and Decorate the Tree', 'Ağaç dalını saksıya yerleştirin ve ışıklarla süsleyin.', 'Place the tree branch in the pot and decorate with lights.', false, 3, 100),
(gen_random_uuid(), 'a58e8489-23c4-45ba-9e8e-f3e60745a3cb', 3, 'Dilek Kartlarını Dağıtma', 'Distribute Wish Cards', 'Arkadaş ve aileye dilek kartları dağıtın, yazmalarını isteyin.', 'Distribute wish cards to friends and family, ask them to write.', false, 2, 0),
(gen_random_uuid(), 'a58e8489-23c4-45ba-9e8e-f3e60745a3cb', 4, 'Kartları Ağaca Asma', 'Hang Cards on the Tree', 'Yazılan dilek kartlarını ağaca asarak tamamlayın.', 'Complete the tree by hanging the written wish cards.', true, 0, 0),
(gen_random_uuid(), 'a58e8489-23c4-45ba-9e8e-f3e60745a3cb', 5, 'Kutlama ve Dilek Okuma', 'Celebration and Wish Reading', 'Ağacı kişiye gösterin ve dilekleri birlikte okuyun.', 'Show the tree to the person and read the wishes together.', true, 0, 0);

-- Scenario: Backyard Drive-In Movie Night (backyard-drive-in)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '24a5ddd4-ec46-4c2e-a2e1-ed709aad038e', 1, 'Ekipman Araştırması ve Tedarik', 'Research and Procure Equipment', 'Projektör, beyaz perde veya çarşaf ve hoparlör sistemi tedarik edin.', 'Procure a projector, white screen or sheet, and speaker system.', false, 7, 800),
(gen_random_uuid(), '24a5ddd4-ec46-4c2e-a2e1-ed709aad038e', 2, 'Film Seçimi', 'Choose the Movie', 'İkinizin de seveceği romantik veya anlamlı bir film seçin.', 'Choose a romantic or meaningful movie you both will enjoy.', false, 5, 0),
(gen_random_uuid(), '24a5ddd4-ec46-4c2e-a2e1-ed709aad038e', 3, 'Bahçe Düzeni ve Oturma Alanı', 'Garden Setup and Seating Area', 'Battaniyeler, yastıklar ve rahat oturma alanı hazırlayın.', 'Prepare blankets, cushions, and a comfortable seating area.', false, 1, 200),
(gen_random_uuid(), '24a5ddd4-ec46-4c2e-a2e1-ed709aad038e', 4, 'Atıştırmalık ve İçecek Hazırlığı', 'Prepare Snacks and Drinks', 'Patlamış mısır, şeker ve özel içecekler hazırlayın.', 'Prepare popcorn, candy, and special drinks.', true, 0, 150),
(gen_random_uuid(), '24a5ddd4-ec46-4c2e-a2e1-ed709aad038e', 5, 'Sinema Gecesini Başlatma', 'Start Movie Night', 'Projektörü kurun, ışıkları kapatın ve film keyfini çıkarın.', 'Set up the projector, turn off the lights, and enjoy the movie.', true, 0, 0);

-- Scenario: Bonsai Growth Journey Anniversary (bonsai-growth-journey)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2d557e68-904d-45b5-88d1-708bc7d86a8f', 1, 'Bonsai Ağacı Seçimi', 'Choose Bonsai Tree', 'İlişkinizi simgeleyecek anlamlı bir bonsai türü seçin.', 'Choose a meaningful bonsai species that symbolizes your relationship.', false, 10, 300),
(gen_random_uuid(), '2d557e68-904d-45b5-88d1-708bc7d86a8f', 2, 'Bonsai Bakım Seti Hazırlama', 'Prepare Bonsai Care Kit', 'Saksı, toprak, makas ve bakım kitapçığı içeren bir set hazırlayın.', 'Prepare a set including pot, soil, scissors, and a care booklet.', false, 5, 200),
(gen_random_uuid(), '2d557e68-904d-45b5-88d1-708bc7d86a8f', 3, 'Kişisel Mesaj ve Anlam Kartı', 'Personal Message and Meaning Card', 'Bonsainin ilişkiniz için ne anlama geldiğini anlatan bir kart yazın.', 'Write a card explaining what the bonsai means for your relationship.', false, 2, 20),
(gen_random_uuid(), '2d557e68-904d-45b5-88d1-708bc7d86a8f', 4, 'Hediye Paketi Düzenleme', 'Arrange Gift Package', 'Bonsai ve bakım setini şık bir hediye olarak paketleyin.', 'Package the bonsai and care set as an elegant gift.', true, 1, 50),
(gen_random_uuid(), '2d557e68-904d-45b5-88d1-708bc7d86a8f', 5, 'Birlikte Dikme Töreni', 'Planting Ceremony Together', 'Bonsaiyi birlikte saksıya dikin ve büyüme yolculuğunu başlatın.', 'Plant the bonsai together in its pot and start the growth journey.', true, 0, 0);

-- Scenario: Nature Bungalow Escape Anniversary (bungalow-escape)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '091de339-7ccd-4ee4-9e42-bbe737f28b55', 1, 'Bungalov Araştırması ve Rezervasyon', 'Research and Book Bungalow', 'Doğada romantik bir bungalov bulun ve tarih için rezervasyon yapın.', 'Find a romantic bungalow in nature and book for the date.', false, 21, 2000),
(gen_random_uuid(), '091de339-7ccd-4ee4-9e42-bbe737f28b55', 2, 'Ulaşım Planlaması', 'Plan Transportation', 'Bungalova nasıl gidileceğini planlayın ve gerekirse araç kiralayın.', 'Plan how to get to the bungalow and rent a car if needed.', false, 10, 500),
(gen_random_uuid(), '091de339-7ccd-4ee4-9e42-bbe737f28b55', 3, 'Romantik Sürpriz Paketi Hazırlama', 'Prepare Romantic Surprise Package', 'Mum, şarap, çikolata ve çiçeklerden oluşan bir romantik paket hazırlayın.', 'Prepare a romantic package with candles, wine, chocolate, and flowers.', false, 3, 400),
(gen_random_uuid(), '091de339-7ccd-4ee4-9e42-bbe737f28b55', 4, 'Aktivite Planlaması', 'Plan Activities', 'Doğa yürüyüşü, şömine başı sohbet gibi aktiviteler planlayın.', 'Plan activities like nature walks and fireside chats.', true, 5, 0),
(gen_random_uuid(), '091de339-7ccd-4ee4-9e42-bbe737f28b55', 5, 'Kaçamak Günü', 'Getaway Day', 'Bungalova gidin ve romantik kaçamağın tadını çıkarın.', 'Go to the bungalow and enjoy the romantic getaway.', true, 0, 0);

-- Scenario: Calligraphy Love Map (calligraphy-love-map)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3924568f-85f9-4127-ae3d-d149253fde9a', 1, 'Kaligrafi Malzemeleri Tedariki', 'Procure Calligraphy Supplies', 'Kaligrafi kalemi, mürekkep ve kaliteli kağıt satın alın.', 'Purchase calligraphy pen, ink, and quality paper.', false, 10, 200),
(gen_random_uuid(), '3924568f-85f9-4127-ae3d-d149253fde9a', 2, 'Aşk Haritası Konsepti Tasarlama', 'Design Love Map Concept', 'İlişkinizdeki önemli mekanları belirleyin ve harita düzenini çizin.', 'Identify important locations in your relationship and sketch the map layout.', false, 7, 0),
(gen_random_uuid(), '3924568f-85f9-4127-ae3d-d149253fde9a', 3, 'Kaligrafi ile Haritayı Oluşturma', 'Create the Map with Calligraphy', 'Mekanları ve anıları kaligrafi ile haritaya işleyin.', 'Add locations and memories to the map using calligraphy.', false, 3, 0),
(gen_random_uuid(), '3924568f-85f9-4127-ae3d-d149253fde9a', 4, 'Çerçeveleme', 'Framing', 'Tamamlanan haritayı şık bir çerçeveye koyun.', 'Place the completed map in an elegant frame.', true, 1, 200),
(gen_random_uuid(), '3924568f-85f9-4127-ae3d-d149253fde9a', 5, 'Hediye Sunumu', 'Gift Presentation', 'Aşk haritasını yıldönümünde özel bir anla sunun.', 'Present the love map on the anniversary at a special moment.', true, 0, 0);

-- Scenario: Candlelight Dinner (candlelight-dinner)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000003-0001-0001-0001-000000000002', 1, 'Menü ve Mekan Planlaması', 'Plan Menu and Venue', 'Ev yemeği mi restoran mı olacağını belirleyin ve menüyü planlayın.', 'Decide between home dinner or restaurant and plan the menu.', false, 7, 0),
(gen_random_uuid(), 'a0000003-0001-0001-0001-000000000002', 2, 'Malzeme ve Dekorasyon Alışverişi', 'Shop for Supplies and Decoration', 'Mumlar, çiçekler, özel tabak takımı ve yemek malzemelerini alın.', 'Buy candles, flowers, special dinnerware, and food ingredients.', false, 3, 500),
(gen_random_uuid(), 'a0000003-0001-0001-0001-000000000002', 3, 'Mekan Hazırlığı', 'Prepare the Venue', 'Masayı kurun, mumları yerleştirin ve romantik ortamı oluşturun.', 'Set the table, place the candles, and create a romantic atmosphere.', false, 0, 0),
(gen_random_uuid(), 'a0000003-0001-0001-0001-000000000002', 4, 'Yemek Pişirme veya Sipariş', 'Cook or Order Food', 'Yemekleri pişirin veya özel bir restorandan sipariş edin.', 'Cook the dishes or order from a special restaurant.', false, 0, 300),
(gen_random_uuid(), 'a0000003-0001-0001-0001-000000000002', 5, 'Romantik Akşam Yemeği', 'Romantic Dinner', 'Mum ışığında özel akşam yemeğinin tadını çıkarın.', 'Enjoy the special dinner by candlelight.', true, 0, 0);

-- Scenario: Cinematic Flashback Reel (cinematic-flashback-reel)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'cd430ce1-d23a-4999-a3cf-247f2836a4de', 1, 'Video ve Fotoğraf Arşivi Tarama', 'Scan Video and Photo Archive', 'İlişkinizdeki önemli anların videolarını ve fotoğraflarını toplayın.', 'Collect videos and photos of important moments in your relationship.', false, 14, 0),
(gen_random_uuid(), 'cd430ce1-d23a-4999-a3cf-247f2836a4de', 2, 'Senaryo ve Kronoloji Oluşturma', 'Create Script and Chronology', 'Anıları kronolojik sıraya koyun ve filmin akışını planlayın.', 'Arrange memories in chronological order and plan the film flow.', false, 10, 0),
(gen_random_uuid(), 'cd430ce1-d23a-4999-a3cf-247f2836a4de', 3, 'Video Düzenleme', 'Edit the Video', 'Profesyonel düzenleme yazılımıyla sinematik bir montaj oluşturun.', 'Create a cinematic montage with professional editing software.', false, 5, 300),
(gen_random_uuid(), 'cd430ce1-d23a-4999-a3cf-247f2836a4de', 4, 'Müzik ve Altyazı Ekleme', 'Add Music and Subtitles', 'Duygusal müzik ve anlamlı altyazılar ekleyin.', 'Add emotional music and meaningful subtitles.', true, 2, 0),
(gen_random_uuid(), 'cd430ce1-d23a-4999-a3cf-247f2836a4de', 5, 'Özel Gösterim Gecesi', 'Private Screening Night', 'Filmi büyük bir ekranda birlikte izleyin.', 'Watch the film together on a big screen.', true, 0, 50);

-- Scenario: Constellation Projector Romantic Night (constellation-projector)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ccd5365e-a0ac-4dd1-aad7-71788b6409d8', 1, 'Yıldız Projektörü Satın Alma', 'Purchase Star Projector', 'Kaliteli bir yıldız ve takımyıldızı projektörü satın alın.', 'Purchase a quality star and constellation projector.', false, 7, 400),
(gen_random_uuid(), 'ccd5365e-a0ac-4dd1-aad7-71788b6409d8', 2, 'Romantik Mekan Hazırlığı', 'Prepare Romantic Setting', 'Yatak odasını veya oturma odasını romantik geceye hazırlayın.', 'Prepare the bedroom or living room for the romantic night.', false, 2, 100),
(gen_random_uuid(), 'ccd5365e-a0ac-4dd1-aad7-71788b6409d8', 3, 'Yıldız Bilgisi Araştırması', 'Research Star Knowledge', 'Özel takımyıldızları ve anlamları hakkında bilgi edinin.', 'Learn about special constellations and their meanings.', false, 3, 0),
(gen_random_uuid(), 'ccd5365e-a0ac-4dd1-aad7-71788b6409d8', 4, 'Atıştırmalık ve İçecek Hazırlığı', 'Prepare Snacks and Drinks', 'Şarap, çikolata ve meyve tabağı hazırlayın.', 'Prepare wine, chocolate, and a fruit platter.', true, 0, 200),
(gen_random_uuid(), 'ccd5365e-a0ac-4dd1-aad7-71788b6409d8', 5, 'Yıldızlı Romantik Gece', 'Starry Romantic Night', 'Projektörü açın ve yıldızlar altında romantik bir gece geçirin.', 'Turn on the projector and spend a romantic night under the stars.', true, 0, 0);

-- Scenario: Cooking Together Anniversary Night (cooking-together-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5fd1c680-f51c-45f0-93e2-6c99ea3744be', 1, 'Tarif Seçimi', 'Choose Recipe', 'Birlikte pişireceğiniz özel ve lezzetli bir tarif seçin.', 'Choose a special and delicious recipe to cook together.', false, 7, 0),
(gen_random_uuid(), '5fd1c680-f51c-45f0-93e2-6c99ea3744be', 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Tarif için gerekli tüm malzemeleri satın alın.', 'Purchase all necessary ingredients for the recipe.', false, 2, 300),
(gen_random_uuid(), '5fd1c680-f51c-45f0-93e2-6c99ea3744be', 3, 'Mutfak Hazırlığı', 'Kitchen Preparation', 'Mutfağı düzenleyin, önlükler ve müzik hazırlayın.', 'Organize the kitchen, prepare aprons and music.', false, 0, 50),
(gen_random_uuid(), '5fd1c680-f51c-45f0-93e2-6c99ea3744be', 4, 'Masa Dekorasyonu', 'Table Decoration', 'Yemek sonrası için masayı şık bir şekilde hazırlayın.', 'Elegantly set the table for after the cooking.', true, 0, 100),
(gen_random_uuid(), '5fd1c680-f51c-45f0-93e2-6c99ea3744be', 5, 'Birlikte Pişirme ve Yemek', 'Cook and Dine Together', 'Birlikte yemeği pişirin ve hazırladığınız sofradan keyif alın.', 'Cook the meal together and enjoy the table you prepared.', true, 0, 0);

-- Scenario: Couple Ring Ceremony Anniversary (couple-ring-ceremony)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5575237a-faa9-4919-9072-dd70f6982316', 1, 'Yüzük Seçimi ve Siparişi', 'Select and Order Rings', 'Çift için anlamlı yüzükleri seçin ve sipariş edin.', 'Select meaningful rings for the couple and place the order.', false, 21, 1500),
(gen_random_uuid(), '5575237a-faa9-4919-9072-dd70f6982316', 2, 'Tören Mekanı Belirleme', 'Determine Ceremony Venue', 'Yüzük takma töreni için romantik bir mekan seçin.', 'Choose a romantic venue for the ring ceremony.', false, 14, 0),
(gen_random_uuid(), '5575237a-faa9-4919-9072-dd70f6982316', 3, 'Tören Senaryosu Hazırlama', 'Prepare Ceremony Script', 'Yüzük değişim anı için duygusal sözler ve senaryo hazırlayın.', 'Prepare emotional words and a script for the ring exchange moment.', false, 5, 0),
(gen_random_uuid(), '5575237a-faa9-4919-9072-dd70f6982316', 4, 'Mekan Dekorasyonu', 'Venue Decoration', 'Mekanı çiçekler, mumlar ve romantik süslerle donatın.', 'Decorate the venue with flowers, candles, and romantic ornaments.', true, 1, 300),
(gen_random_uuid(), '5575237a-faa9-4919-9072-dd70f6982316', 5, 'Yüzük Töreni', 'Ring Ceremony', 'Yüzükleri birbirinize takın ve özel anın tadını çıkarın.', 'Exchange rings and enjoy the special moment.', true, 0, 0);

-- Scenario: Couples Pottery Class Anniversary (couples-pottery-class)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0d7ddfa1-dde1-4bb3-8bce-a9451c2d06d7', 1, 'Seramik Atölyesi Araştırması', 'Research Pottery Studios', 'Çiftler için seramik kursu veren atölyeleri araştırın.', 'Research studios offering pottery classes for couples.', false, 14, 0),
(gen_random_uuid(), '0d7ddfa1-dde1-4bb3-8bce-a9451c2d06d7', 2, 'Rezervasyon Yapma', 'Make Reservation', 'Uygun tarihte çiftlere özel seramik atölyesi rezervasyonu yapın.', 'Book a couples pottery class for a suitable date.', false, 7, 600),
(gen_random_uuid(), '0d7ddfa1-dde1-4bb3-8bce-a9451c2d06d7', 3, 'Kıyafet ve Hazırlık', 'Outfit and Preparation', 'Kirlenebilecek rahat kıyafetler ve önlükler hazırlayın.', 'Prepare comfortable clothes and aprons that can get dirty.', false, 2, 0),
(gen_random_uuid(), '0d7ddfa1-dde1-4bb3-8bce-a9451c2d06d7', 4, 'Sürpriz Açıklama Planı', 'Plan Surprise Reveal', 'Atölye sürprizini nasıl açıklayacağınızı planlayın.', 'Plan how you will reveal the workshop surprise.', true, 1, 0),
(gen_random_uuid(), '0d7ddfa1-dde1-4bb3-8bce-a9451c2d06d7', 5, 'Atölye Günü', 'Workshop Day', 'Birlikte seramik yapmanın keyfini çıkarın ve eserlerinizi saklayın.', 'Enjoy making pottery together and keep your creations.', true, 0, 0);

-- Scenario: Custom Board Game Anniversary Surprise (custom-board-game-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6943cc5d-d319-4cbc-878c-723bc218725b', 1, 'Oyun Konsepti Tasarlama', 'Design Game Concept', 'İlişkinizdeki anılara dayalı bir kutu oyunu konsepti oluşturun.', 'Create a board game concept based on memories from your relationship.', false, 21, 0),
(gen_random_uuid(), '6943cc5d-d319-4cbc-878c-723bc218725b', 2, 'Oyun Kuralları ve İçerik Hazırlama', 'Prepare Game Rules and Content', 'Soru kartları, görevler ve oyun kurallarını yazın.', 'Write question cards, tasks, and game rules.', false, 14, 0),
(gen_random_uuid(), '6943cc5d-d319-4cbc-878c-723bc218725b', 3, 'Grafik Tasarım ve Üretim', 'Graphic Design and Production', 'Oyun tahtası, kartları ve kutuyu tasarlayın ve üretin.', 'Design and produce the game board, cards, and box.', false, 7, 500),
(gen_random_uuid(), '6943cc5d-d319-4cbc-878c-723bc218725b', 4, 'Test Oynama', 'Test Play', 'Oyunu kendiniz test edin ve gerekli düzeltmeleri yapın.', 'Test the game yourself and make necessary corrections.', true, 3, 0),
(gen_random_uuid(), '6943cc5d-d319-4cbc-878c-723bc218725b', 5, 'Oyun Gecesi Hediyesi', 'Game Night Gift', 'Kutu oyununu yıldönümünde hediye edin ve birlikte oynayın.', 'Gift the board game on the anniversary and play together.', true, 0, 0);

-- Scenario: Surprise Dance Lesson Anniversary (dance-lesson-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4681eabd-a64c-4fab-870d-65c36c466d41', 1, 'Dans Okulu Araştırması', 'Research Dance Schools', 'Çiftlere özel dans dersi veren okulları araştırın.', 'Research dance schools offering private lessons for couples.', false, 14, 0),
(gen_random_uuid(), '4681eabd-a64c-4fab-870d-65c36c466d41', 2, 'Dans Stili ve Ders Rezervasyonu', 'Book Dance Style and Lesson', 'Vals, tango veya salsa gibi bir stil seçin ve ders ayırtın.', 'Choose a style like waltz, tango, or salsa and book the lesson.', false, 7, 500),
(gen_random_uuid(), '4681eabd-a64c-4fab-870d-65c36c466d41', 3, 'Kıyafet Hazırlığı', 'Outfit Preparation', 'Dans için uygun kıyafetler ve ayakkabılar hazırlayın.', 'Prepare suitable clothes and shoes for dancing.', false, 3, 200),
(gen_random_uuid(), '4681eabd-a64c-4fab-870d-65c36c466d41', 4, 'Sürpriz Açıklama', 'Reveal the Surprise', 'Dans dersi sürprizini yaratıcı bir şekilde açıklayın.', 'Reveal the dance lesson surprise in a creative way.', true, 1, 0),
(gen_random_uuid(), '4681eabd-a64c-4fab-870d-65c36c466d41', 5, 'Dans Dersi Günü', 'Dance Lesson Day', 'Birlikte dans etmenin keyfini çıkarın ve yeni adımlar öğrenin.', 'Enjoy dancing together and learn new steps.', true, 0, 0);

-- Scenario: Decade Photo Recreation Anniversary (decade-photo-recreation)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '395dbe4f-e4b0-48c9-93e0-93f1280474aa', 1, 'Eski Fotoğrafları Toplama', 'Collect Old Photos', 'On yıl öncesine ait önemli fotoğrafları bulun ve seçin.', 'Find and select important photos from ten years ago.', false, 14, 0),
(gen_random_uuid(), '395dbe4f-e4b0-48c9-93e0-93f1280474aa', 2, 'Mekan ve Kıyafet Planlama', 'Plan Locations and Outfits', 'Fotoğrafların çekildiği mekanları ve benzer kıyafetleri belirleyin.', 'Identify the locations and similar outfits from the original photos.', false, 7, 200),
(gen_random_uuid(), '395dbe4f-e4b0-48c9-93e0-93f1280474aa', 3, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Profesyonel bir fotoğrafçı ile anlaşın ve çekim günü belirleyin.', 'Agree with a professional photographer and set the shooting day.', false, 5, 800),
(gen_random_uuid(), '395dbe4f-e4b0-48c9-93e0-93f1280474aa', 4, 'Fotoğraf Çekimi', 'Photo Shoot', 'Eski fotoğrafları aynı mekanlarda yeniden canlandırarak çekim yapın.', 'Recreate the old photos by shooting at the same locations.', true, 1, 0),
(gen_random_uuid(), '395dbe4f-e4b0-48c9-93e0-93f1280474aa', 5, 'Karşılaştırma Albümü Hazırlama', 'Prepare Comparison Album', 'Eski ve yeni fotoğrafları yan yana koyarak albüm oluşturun.', 'Create an album placing old and new photos side by side.', true, 0, 200);

-- Scenario: First Date Recreation Anniversary (first-date-recreation)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7ebd8db5-47f4-4df1-9440-b0fd93c06384', 1, 'İlk Buluşma Detaylarını Hatırlama', 'Recall First Date Details', 'İlk buluşmanızın mekanını, yemeğini ve detaylarını hatırlayın.', 'Recall the venue, food, and details of your first date.', false, 14, 0),
(gen_random_uuid(), '7ebd8db5-47f4-4df1-9440-b0fd93c06384', 2, 'Mekan Rezervasyonu', 'Reserve the Venue', 'İlk buluşma mekanında veya benzer bir yerde rezervasyon yapın.', 'Make a reservation at the first date venue or a similar place.', false, 7, 0),
(gen_random_uuid(), '7ebd8db5-47f4-4df1-9440-b0fd93c06384', 3, 'Kıyafet ve Detay Hazırlığı', 'Prepare Outfit and Details', 'İlk buluşmadaki kıyafetlerinize benzer giysiler hazırlayın.', 'Prepare clothes similar to what you wore on the first date.', false, 3, 200),
(gen_random_uuid(), '7ebd8db5-47f4-4df1-9440-b0fd93c06384', 4, 'Sürpriz Detaylar Ekleme', 'Add Surprise Details', 'İlk buluşmadan özel anı objeleri veya detaylar ekleyin.', 'Add special memorabilia or details from the first date.', true, 1, 100),
(gen_random_uuid(), '7ebd8db5-47f4-4df1-9440-b0fd93c06384', 5, 'İlk Buluşmayı Yeniden Yaşama', 'Relive the First Date', 'Her şeyi ilk buluşma gibi yaşayın ve anıları tazeleyin.', 'Experience everything like the first date and refresh memories.', true, 0, 500);

-- Scenario: Gatsby Themed Anniversary Party (gatsby-themed-party)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ee56933e-8ceb-4f9b-9511-691a661ccf36', 1, 'Parti Konsepti ve Mekan', 'Party Concept and Venue', '1920''''lerin Gatsby temasına uygun bir mekan belirleyin.', 'Choose a venue suitable for the 1920s Gatsby theme.', false, 21, 1000),
(gen_random_uuid(), 'ee56933e-8ceb-4f9b-9511-691a661ccf36', 2, 'Kostüm ve Aksesuarlar', 'Costumes and Accessories', 'Gatsby dönemine uygun kostümler ve aksesuarlar tedarik edin.', 'Procure costumes and accessories fitting the Gatsby era.', false, 14, 800),
(gen_random_uuid(), 'ee56933e-8ceb-4f9b-9511-691a661ccf36', 3, 'Dekorasyon ve Müzik', 'Decoration and Music', 'Art deco süslemeler, caz müziği ve altın renkli dekorasyonlar hazırlayın.', 'Prepare Art Deco decorations, jazz music, and gold-colored decor.', false, 5, 1000),
(gen_random_uuid(), 'ee56933e-8ceb-4f9b-9511-691a661ccf36', 4, 'Yiyecek ve İçecek Menüsü', 'Food and Drink Menu', 'Dönem kokteylleri ve zarif aperatifler hazırlayın.', 'Prepare period cocktails and elegant appetizers.', true, 2, 800),
(gen_random_uuid(), 'ee56933e-8ceb-4f9b-9511-691a661ccf36', 5, 'Gatsby Partisi Gecesi', 'Gatsby Party Night', 'Muhteşem Gatsby temalı yıldönümü partisinin tadını çıkarın.', 'Enjoy the magnificent Gatsby-themed anniversary party.', true, 0, 0);

-- Scenario: Handprint Ceramic Bowl Anniversary (handprint-bowl-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '13be9fd9-f618-4e83-a82e-f874a72c720f', 1, 'Seramik Atölyesi Bulma', 'Find Pottery Studio', 'El izi baskılı kase yapabilecek bir seramik atölyesi bulun.', 'Find a pottery studio where you can make a handprint bowl.', false, 14, 0),
(gen_random_uuid(), '13be9fd9-f618-4e83-a82e-f874a72c720f', 2, 'Atölye Randevusu Alma', 'Book Studio Appointment', 'Çiftlere özel seramik atölyesi randevusu alın.', 'Book a pottery workshop appointment for couples.', false, 7, 400),
(gen_random_uuid(), '13be9fd9-f618-4e83-a82e-f874a72c720f', 3, 'Tasarım Planı Hazırlama', 'Prepare Design Plan', 'Kaseye uygulanacak renk ve desenleri planlayın.', 'Plan the colors and patterns to be applied to the bowl.', false, 3, 0),
(gen_random_uuid(), '13be9fd9-f618-4e83-a82e-f874a72c720f', 4, 'Atölyede Kase Yapımı', 'Make Bowl at Workshop', 'Birlikte seramik kase yapın ve el izlerinizi bırakın.', 'Make a ceramic bowl together and leave your handprints.', true, 0, 0),
(gen_random_uuid(), '13be9fd9-f618-4e83-a82e-f874a72c720f', 5, 'Kaseyi Teslim Alma ve Kullanma', 'Pick Up and Use the Bowl', 'Pişirilen kaseyi teslim alın ve evinizde özel bir yere koyun.', 'Pick up the fired bowl and place it in a special spot at home.', true, 0, 0);

-- Scenario: Italian Passeggiata Evening (italian-passeggiata)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b956b5a6-552a-4f1a-b436-2f08bb319ebf', 1, 'İtalyan Atmosferi Araştırması', 'Research Italian Atmosphere', 'İtalyan tarzı sokaklar veya semtleri araştırın ve rota belirleyin.', 'Research Italian-style streets or neighborhoods and determine a route.', false, 7, 0),
(gen_random_uuid(), 'b956b5a6-552a-4f1a-b436-2f08bb319ebf', 2, 'İtalyan Yemek Rezervasyonu', 'Italian Dinner Reservation', 'Otantik bir İtalyan restoranında akşam yemeği rezervasyonu yapın.', 'Make a dinner reservation at an authentic Italian restaurant.', false, 5, 0),
(gen_random_uuid(), 'b956b5a6-552a-4f1a-b436-2f08bb319ebf', 3, 'Kıyafet ve Hazırlık', 'Outfit and Preparation', 'Şık İtalyan tarzı kıyafetler hazırlayın.', 'Prepare stylish Italian-style outfits.', false, 2, 200),
(gen_random_uuid(), 'b956b5a6-552a-4f1a-b436-2f08bb319ebf', 4, 'Gelato ve Kahve Durakları Planlama', 'Plan Gelato and Coffee Stops', 'Yürüyüş rotasında gelato ve espresso molaları planlayın.', 'Plan gelato and espresso stops along the walking route.', true, 1, 100),
(gen_random_uuid(), 'b956b5a6-552a-4f1a-b436-2f08bb319ebf', 5, 'Passeggiata Akşamı', 'Passeggiata Evening', 'İtalyan usulü akşam yürüyüşü yapın ve gecenin tadını çıkarın.', 'Take an Italian-style evening stroll and enjoy the night.', true, 0, 500);

-- Scenario: Korean 100-Day Countdown Box (korean-100-day-box)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6ee6037d-0e39-410f-a669-36d81be94366', 1, 'Kutu Tasarımı ve Tedariki', 'Design and Procure Box', '100 günlük anıları saklayacak özel bir kutu satın alın veya yaptırın.', 'Purchase or have made a special box to store 100 days of memories.', false, 10, 200),
(gen_random_uuid(), '6ee6037d-0e39-410f-a669-36d81be94366', 2, '100 Günlük Anı Toplama', 'Collect 100-Day Memories', 'Her gün için bir fotoğraf, not veya küçük hatıra toplayın.', 'Collect a photo, note, or small memento for each day.', false, 7, 100),
(gen_random_uuid(), '6ee6037d-0e39-410f-a669-36d81be94366', 3, 'İçerik Düzenleme', 'Organize Contents', 'Anıları kronolojik sıraya koyun ve etiketleyin.', 'Arrange memories in chronological order and label them.', false, 3, 0),
(gen_random_uuid(), '6ee6037d-0e39-410f-a669-36d81be94366', 4, 'Kişisel Mektup Ekleme', 'Add Personal Letter', '100 gün için duygusal bir mektup yazarak kutuya ekleyin.', 'Write an emotional letter for the 100 days and add it to the box.', true, 1, 0),
(gen_random_uuid(), '6ee6037d-0e39-410f-a669-36d81be94366', 5, 'Kutuyu Hediye Etme', 'Gift the Box', '100. günde kutuyu sürpriz olarak hediye edin.', 'Gift the box as a surprise on the 100th day.', true, 0, 0);

-- Scenario: Korean Style 100th Day Celebration (korean-100-days)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '87bffbab-93ff-4a1d-b331-f120e7fac7ba', 1, 'Kutlama Planı Oluşturma', 'Create Celebration Plan', '100. gün kutlamasının detaylarını ve programını planlayın.', 'Plan the details and schedule of the 100th day celebration.', false, 10, 0),
(gen_random_uuid(), '87bffbab-93ff-4a1d-b331-f120e7fac7ba', 2, 'Hediye Seçimi ve Tedariki', 'Select and Procure Gifts', 'Kore geleneğine uygun hediyeler satın alın: yüzük, bileklik vb.', 'Purchase gifts according to Korean tradition: rings, bracelets, etc.', false, 7, 500),
(gen_random_uuid(), '87bffbab-93ff-4a1d-b331-f120e7fac7ba', 3, 'Kutlama Mekanı Hazırlama', 'Prepare Celebration Venue', 'Mekanı Kore temalı dekorasyonlarla süsleyin.', 'Decorate the venue with Korean-themed decorations.', false, 2, 200),
(gen_random_uuid(), '87bffbab-93ff-4a1d-b331-f120e7fac7ba', 4, 'Özel Yemek Hazırlama', 'Prepare Special Meal', 'Kore mutfağından özel yemekler hazırlayın veya sipariş edin.', 'Prepare or order special dishes from Korean cuisine.', true, 1, 300),
(gen_random_uuid(), '87bffbab-93ff-4a1d-b331-f120e7fac7ba', 5, '100. Gün Kutlaması', '100th Day Celebration', 'Hediyeleri verin ve birlikte 100. günü kutlayın.', 'Give the gifts and celebrate the 100th day together.', true, 0, 0);

-- Scenario: Library Love Hunt Anniversary (library-hunt-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd677c0e3-1469-41f4-bf97-cdd6a76fdf34', 1, 'Kütüphane Seçimi ve İzin', 'Choose Library and Get Permission', 'Romantik bir kütüphane seçin ve etkinlik için izin alın.', 'Choose a romantic library and get permission for the event.', false, 14, 0),
(gen_random_uuid(), 'd677c0e3-1469-41f4-bf97-cdd6a76fdf34', 2, 'İpuçları ve Bulmacalar Hazırlama', 'Prepare Clues and Puzzles', 'Kitapların arasına saklanacak aşk ipuçları ve bulmacalar yazın.', 'Write love clues and puzzles to be hidden among books.', false, 7, 50),
(gen_random_uuid(), 'd677c0e3-1469-41f4-bf97-cdd6a76fdf34', 3, 'İpuçlarını Yerleştirme', 'Place the Clues', 'İpuçlarını belirli kitapların sayfaları arasına gizleyin.', 'Hide the clues between pages of specific books.', false, 1, 0),
(gen_random_uuid(), 'd677c0e3-1469-41f4-bf97-cdd6a76fdf34', 4, 'Final Sürprizi Hazırlama', 'Prepare Final Surprise', 'Avın sonunda bulunacak özel bir hediye veya mektup hazırlayın.', 'Prepare a special gift or letter to be found at the end of the hunt.', true, 1, 200),
(gen_random_uuid(), 'd677c0e3-1469-41f4-bf97-cdd6a76fdf34', 5, 'Aşk Avı Başlasın', 'Let the Love Hunt Begin', 'Eşinizi kütüphaneye götürün ve ilk ipucunu verin.', 'Take your partner to the library and give the first clue.', true, 0, 0);

-- Scenario: 365 Day Love Jar Anniversary (love-jar-365)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd9eeb961-44b6-424e-8381-3fb257cbeade', 1, 'Kavanoz ve Malzeme Seçimi', 'Choose Jar and Materials', 'Dekoratif bir kavanoz ve 365 adet renkli kağıt satın alın.', 'Purchase a decorative jar and 365 colorful papers.', false, 30, 100),
(gen_random_uuid(), 'd9eeb961-44b6-424e-8381-3fb257cbeade', 2, 'Günlük Mesajlar Yazma', 'Write Daily Messages', 'Her gün için bir sevgi mesajı, anı veya aktivite önerisi yazın.', 'Write a love message, memory, or activity suggestion for each day.', false, 21, 0),
(gen_random_uuid(), 'd9eeb961-44b6-424e-8381-3fb257cbeade', 3, 'Mesajları Katlayıp Yerleştirme', 'Fold and Place Messages', 'Tüm mesajları güzelce katlayın ve kavanoza yerleştirin.', 'Neatly fold all messages and place them in the jar.', false, 7, 0),
(gen_random_uuid(), 'd9eeb961-44b6-424e-8381-3fb257cbeade', 4, 'Kavanoz Dekorasyonu', 'Decorate the Jar', 'Kavanozu kurdeleler ve etiketlerle süsleyin.', 'Decorate the jar with ribbons and labels.', true, 3, 50),
(gen_random_uuid(), 'd9eeb961-44b6-424e-8381-3fb257cbeade', 5, 'Kavanozu Hediye Etme', 'Gift the Jar', '365 günlük aşk kavanozunu yıldönümünde hediye edin.', 'Gift the 365-day love jar on the anniversary.', true, 0, 0);

-- Scenario: Love Letter Chain Anniversary (love-letter-chain)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4cd00272-e171-4399-a8fb-430516c85759', 1, 'Mektup Serisi Planlama', 'Plan Letter Series', 'İlişkinizdeki önemli anılara göre mektup konularını belirleyin.', 'Determine letter topics based on important memories in your relationship.', false, 14, 0),
(gen_random_uuid(), '4cd00272-e171-4399-a8fb-430516c85759', 2, 'Mektupları Yazma', 'Write the Letters', 'Her bir mektubu duygusal ve samimi bir şekilde el yazısıyla yazın.', 'Write each letter by hand in an emotional and sincere manner.', false, 7, 0),
(gen_random_uuid(), '4cd00272-e171-4399-a8fb-430516c85759', 3, 'Zarfları ve Süslemeleri Hazırlama', 'Prepare Envelopes and Decorations', 'Özel zarflar alın ve her birini farklı şekilde süsleyin.', 'Get special envelopes and decorate each one differently.', false, 3, 100),
(gen_random_uuid(), '4cd00272-e171-4399-a8fb-430516c85759', 4, 'Mektup Sırasını ve Buluş Yerlerini Belirleme', 'Determine Letter Order and Hiding Spots', 'Mektupları hangi sırayla ve nerede bulunacağını planlayın.', 'Plan the order and locations where each letter will be found.', true, 1, 0),
(gen_random_uuid(), '4cd00272-e171-4399-a8fb-430516c85759', 5, 'Mektup Zincirini Başlatma', 'Start the Letter Chain', 'İlk mektubu verin veya saklayın ve macera başlasın.', 'Give or hide the first letter and let the adventure begin.', true, 0, 0);

-- Scenario: Love Lock Bridge Anniversary Ritual (love-lock-bridge)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '132ed337-5371-4681-ad45-4d374a2e3621', 1, 'Kilit ve Anahtar Seçimi', 'Choose Lock and Key', 'Kalp şeklinde veya özel gravürlü bir kilit satın alın.', 'Purchase a heart-shaped or custom-engraved lock.', false, 7, 100),
(gen_random_uuid(), '132ed337-5371-4681-ad45-4d374a2e3621', 2, 'Köprü veya Mekan Araştırması', 'Research Bridge or Location', 'Aşk kilidi asılabilecek bir köprü veya uygun mekan bulun.', 'Find a bridge or suitable location for hanging the love lock.', false, 5, 0),
(gen_random_uuid(), '132ed337-5371-4681-ad45-4d374a2e3621', 3, 'Kilit Üzerine Yazı veya Gravür', 'Engraving on the Lock', 'Kilidin üzerine isimlerinizi ve tarihi yazdırın.', 'Have your names and date engraved on the lock.', false, 3, 100),
(gen_random_uuid(), '132ed337-5371-4681-ad45-4d374a2e3621', 4, 'Ziyaret Planı', 'Visit Plan', 'Köprüye gidiş saatini ve sonrasındaki planı belirleyin.', 'Determine the time to visit the bridge and the plan afterwards.', true, 1, 0),
(gen_random_uuid(), '132ed337-5371-4681-ad45-4d374a2e3621', 5, 'Kilit Asma Ritüeli', 'Lock Hanging Ritual', 'Kilidi birlikte asın, anahtarı atın ve dilek tutun.', 'Hang the lock together, throw the key, and make a wish.', true, 0, 0);

-- Scenario: Memory Book Anniversary Surprise (memory-book-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c3da9b68-24d4-4988-b1fc-83589a381451', 1, 'Anı Kitabı Malzemeleri Tedariki', 'Procure Memory Book Supplies', 'Boş bir anı defteri, yapıştırıcı, sticker ve süsleme malzemeleri alın.', 'Get a blank memory book, glue, stickers, and decoration supplies.', false, 14, 200),
(gen_random_uuid(), 'c3da9b68-24d4-4988-b1fc-83589a381451', 2, 'Fotoğraf ve Anı Seçimi', 'Select Photos and Memories', 'İlişkinizdeki en güzel anıların fotoğraflarını seçin.', 'Select photos of the most beautiful memories in your relationship.', false, 10, 0),
(gen_random_uuid(), 'c3da9b68-24d4-4988-b1fc-83589a381451', 3, 'Sayfa Tasarımı ve Düzenleme', 'Design and Arrange Pages', 'Her sayfayı farklı bir anıya adayarak tasarlayın ve düzenleyin.', 'Design and arrange each page dedicated to a different memory.', false, 5, 0),
(gen_random_uuid(), 'c3da9b68-24d4-4988-b1fc-83589a381451', 4, 'Kişisel Notlar Ekleme', 'Add Personal Notes', 'Her sayfaya el yazısıyla kişisel notlar ve duygularınızı ekleyin.', 'Add handwritten personal notes and feelings to each page.', true, 2, 0),
(gen_random_uuid(), 'c3da9b68-24d4-4988-b1fc-83589a381451', 5, 'Kitabı Hediye Etme', 'Gift the Book', 'Anı kitabını yıldönümünde duygusal bir anla sunun.', 'Present the memory book on the anniversary at an emotional moment.', true, 0, 0);

-- Scenario: Message in a Bottle Anniversary (message-bottle-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'bdc2558b-5cf4-4ffc-8575-81523666fb69', 1, 'Şişe ve Malzeme Tedariki', 'Procure Bottle and Supplies', 'Dekoratif bir cam şişe, parşömen kağıdı ve mühür mumu alın.', 'Get a decorative glass bottle, parchment paper, and sealing wax.', false, 7, 100),
(gen_random_uuid(), 'bdc2558b-5cf4-4ffc-8575-81523666fb69', 2, 'Mesaj Yazma', 'Write the Message', 'Duygusal ve anlamlı bir mesaj veya aşk mektubu yazın.', 'Write an emotional and meaningful message or love letter.', false, 5, 0),
(gen_random_uuid(), 'bdc2558b-5cf4-4ffc-8575-81523666fb69', 3, 'Şişeyi Hazırlama ve Süsleme', 'Prepare and Decorate the Bottle', 'Mesajı rulo yapıp şişeye koyun, mühürleyin ve süsleyin.', 'Roll the message, put it in the bottle, seal, and decorate.', false, 2, 30),
(gen_random_uuid(), 'bdc2558b-5cf4-4ffc-8575-81523666fb69', 4, 'Sunum Ortamı Hazırlama', 'Prepare Presentation Setting', 'Şişeyi sunacağınız romantik ortamı hazırlayın.', 'Prepare the romantic setting where you will present the bottle.', true, 0, 50),
(gen_random_uuid(), 'bdc2558b-5cf4-4ffc-8575-81523666fb69', 5, 'Şişeyi Sunma', 'Present the Bottle', 'Şişeyi sürpriz bir şekilde hediye edin ve birlikte açın.', 'Gift the bottle as a surprise and open it together.', true, 0, 0);

-- Scenario: Personalized Map Art Anniversary (personalized-map-art)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'dcbe3bec-bc63-484a-ae9b-f52c5be5f315', 1, 'Önemli Mekanları Belirleme', 'Identify Important Locations', 'İlişkinizdeki önemli mekanları listeleyin: tanışma, ilk buluşma vb.', 'List important locations in your relationship: meeting place, first date, etc.', false, 10, 0),
(gen_random_uuid(), 'dcbe3bec-bc63-484a-ae9b-f52c5be5f315', 2, 'Harita Tasarımı', 'Map Design', 'Mekanları işaretleyen özel bir harita tasarımı oluşturun veya yaptırın.', 'Create or commission a custom map design marking the locations.', false, 7, 400),
(gen_random_uuid(), 'dcbe3bec-bc63-484a-ae9b-f52c5be5f315', 3, 'Baskı ve Kalite Kontrolü', 'Print and Quality Check', 'Haritayı yüksek kalitede bastırın ve renkleri kontrol edin.', 'Print the map in high quality and check the colors.', false, 3, 200),
(gen_random_uuid(), 'dcbe3bec-bc63-484a-ae9b-f52c5be5f315', 4, 'Çerçeveleme', 'Framing', 'Haritayı şık bir çerçeveye koyun.', 'Place the map in an elegant frame.', true, 2, 200),
(gen_random_uuid(), 'dcbe3bec-bc63-484a-ae9b-f52c5be5f315', 5, 'Hediye Sunumu', 'Gift Presentation', 'Kişiselleştirilmiş haritayı yıldönümünde hediye edin.', 'Gift the personalized map on the anniversary.', true, 0, 0);

-- Scenario: Photo Calendar Anniversary Gift (photo-calendar-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '91e1aa0a-314b-4799-9928-0272c6cd8088', 1, 'Fotoğraf Seçimi', 'Select Photos', 'Her ay için en güzel bir fotoğrafı seçin (toplam 12 fotoğraf).', 'Select the most beautiful photo for each month (12 photos total).', false, 14, 0),
(gen_random_uuid(), '91e1aa0a-314b-4799-9928-0272c6cd8088', 2, 'Takvim Tasarımı', 'Calendar Design', 'Fotoğrafları ve önemli tarihleri içeren takvim tasarımını yapın.', 'Create the calendar design including photos and important dates.', false, 7, 0),
(gen_random_uuid(), '91e1aa0a-314b-4799-9928-0272c6cd8088', 3, 'Baskı Siparişi', 'Print Order', 'Takvimi profesyonel bir baskı merkezinden sipariş edin.', 'Order the calendar from a professional print center.', false, 5, 200),
(gen_random_uuid(), '91e1aa0a-314b-4799-9928-0272c6cd8088', 4, 'Özel Tarihleri İşaretleme', 'Mark Special Dates', 'Yıldönümleri ve özel günleri el yazısıyla takvime işleyin.', 'Handwrite anniversaries and special days on the calendar.', true, 1, 0),
(gen_random_uuid(), '91e1aa0a-314b-4799-9928-0272c6cd8088', 5, 'Hediye Sunumu', 'Gift Presentation', 'Fotoğraflı takvimi yıldönümünde hediye edin.', 'Gift the photo calendar on the anniversary.', true, 0, 0);

-- Scenario: Private Chef Dinner Anniversary (private-chef-dinner)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6c43cb0d-46b6-411b-82d6-23749e581a57', 1, 'Özel Şef Araştırması', 'Research Private Chefs', 'Özel yemek hizmeti sunan şefleri araştırın ve referanslarını inceleyin.', 'Research private chefs and review their references.', false, 21, 0),
(gen_random_uuid(), '6c43cb0d-46b6-411b-82d6-23749e581a57', 2, 'Şef ile Anlaşma ve Menü', 'Agree with Chef on Menu', 'Şefi seçin, menüyü birlikte planlayın ve tarih belirleyin.', 'Select the chef, plan the menu together, and set the date.', false, 14, 3000),
(gen_random_uuid(), '6c43cb0d-46b6-411b-82d6-23749e581a57', 3, 'Mekan ve Dekorasyon Hazırlığı', 'Prepare Venue and Decoration', 'Yemek yapılacak mekanı temizleyin ve romantik bir ortam oluşturun.', 'Clean the dining venue and create a romantic atmosphere.', false, 2, 500),
(gen_random_uuid(), '6c43cb0d-46b6-411b-82d6-23749e581a57', 4, 'Müzik ve Ambiyans', 'Music and Ambiance', 'Romantik müzik listesi hazırlayın ve ışıklandırmayı ayarlayın.', 'Prepare a romantic playlist and adjust the lighting.', true, 1, 0),
(gen_random_uuid(), '6c43cb0d-46b6-411b-82d6-23749e581a57', 5, 'Özel Şef Akşam Yemeği', 'Private Chef Dinner', 'Şefin hazırladığı özel menünün tadını çıkarın.', 'Enjoy the special menu prepared by the chef.', true, 0, 0);

-- Scenario: Vow Renewal Ceremony Anniversary (renewal-vows-ceremony)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e1884b99-b25c-4bce-bd39-544f18df08cb', 1, 'Tören Planlaması', 'Plan the Ceremony', 'Nikah yemini yenileme töreninin formatını ve stilini planlayın.', 'Plan the format and style of the vow renewal ceremony.', false, 30, 0),
(gen_random_uuid(), 'e1884b99-b25c-4bce-bd39-544f18df08cb', 2, 'Mekan ve Nikah Memuru Ayarlama', 'Arrange Venue and Officiant', 'Tören mekanını seçin ve yetkili bir nikah memuru veya din görevlisi ayarlayın.', 'Choose the ceremony venue and arrange an officiant.', false, 21, 1000),
(gen_random_uuid(), 'e1884b99-b25c-4bce-bd39-544f18df08cb', 3, 'Kıyafet ve Yüzük Hazırlığı', 'Prepare Outfits and Rings', 'Törene uygun kıyafetler seçin ve isterseniz yeni yüzükler alın.', 'Choose appropriate outfits and optionally get new rings.', false, 14, 2000),
(gen_random_uuid(), 'e1884b99-b25c-4bce-bd39-544f18df08cb', 4, 'Yemin Sözlerini Yazma', 'Write Vow Words', 'Birbirinize söyleyeceğiniz yeni yemin sözlerini kaleme alın.', 'Write new vow words you will say to each other.', true, 7, 0),
(gen_random_uuid(), 'e1884b99-b25c-4bce-bd39-544f18df08cb', 5, 'Yenileme Töreni', 'Renewal Ceremony', 'Nikah yeminlerinizi yenileyin ve bu özel anı kutlayın.', 'Renew your vows and celebrate this special moment.', true, 0, 500);

-- Scenario: Rooftop Stargazing Anniversary Night (rooftop-stargazing-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0cfd5a64-0ccb-49ce-a864-fb243db77bb5', 1, 'Çatı Katı Mekanı Ayarlama', 'Arrange Rooftop Venue', 'Yıldız gözlemi yapılabilecek uygun bir çatı katı bulun.', 'Find a suitable rooftop where stargazing is possible.', false, 10, 0),
(gen_random_uuid(), '0cfd5a64-0ccb-49ce-a864-fb243db77bb5', 2, 'Teleskop ve Ekipman Tedariki', 'Procure Telescope and Equipment', 'Teleskop veya dürbün kiralayın veya satın alın.', 'Rent or purchase a telescope or binoculars.', false, 5, 500),
(gen_random_uuid(), '0cfd5a64-0ccb-49ce-a864-fb243db77bb5', 3, 'Oturma Alanı ve Dekorasyon', 'Seating Area and Decoration', 'Battaniye, yastık ve mumlarla rahat bir gözlem alanı oluşturun.', 'Create a comfortable observation area with blankets, cushions, and candles.', false, 2, 200),
(gen_random_uuid(), '0cfd5a64-0ccb-49ce-a864-fb243db77bb5', 4, 'Yıldız Haritası Hazırlama', 'Prepare Star Map', 'O geceye özel yıldız haritası yazdırın veya uygulama hazırlayın.', 'Print a star map specific to that night or prepare an app.', true, 1, 50),
(gen_random_uuid(), '0cfd5a64-0ccb-49ce-a864-fb243db77bb5', 5, 'Yıldız Gözlemi Gecesi', 'Stargazing Night', 'Çatı katında yıldızları izleyin ve romantik bir gece geçirin.', 'Watch the stars on the rooftop and spend a romantic night.', true, 0, 100);

-- Scenario: Handmade Scrapbook Anniversary Surprise (scrapbook-surprise-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2b13901b-2873-436c-a54f-504aeca57fa7', 1, 'Karalama Defteri Malzemeleri', 'Scrapbook Supplies', 'Boş karalama defteri, yapıştırıcı, washi tape ve süsleme alın.', 'Get a blank scrapbook, glue, washi tape, and decorations.', false, 14, 200),
(gen_random_uuid(), '2b13901b-2873-436c-a54f-504aeca57fa7', 2, 'Fotoğraf ve Bilet Toplama', 'Collect Photos and Tickets', 'Birlikte olduğunuz anlardan fotoğraflar ve biletler toplayın.', 'Collect photos and tickets from moments you shared together.', false, 10, 0),
(gen_random_uuid(), '2b13901b-2873-436c-a54f-504aeca57fa7', 3, 'Sayfa Düzeni ve Tasarım', 'Page Layout and Design', 'Her sayfayı farklı bir tema veya anıyla tasarlayın.', 'Design each page with a different theme or memory.', false, 5, 0),
(gen_random_uuid(), '2b13901b-2873-436c-a54f-504aeca57fa7', 4, 'El Yazısı Notlar Ekleme', 'Add Handwritten Notes', 'Her sayfaya kişisel mesajlar ve duygularınızı yazın.', 'Write personal messages and your feelings on each page.', true, 2, 0),
(gen_random_uuid(), '2b13901b-2873-436c-a54f-504aeca57fa7', 5, 'Defteri Hediye Etme', 'Gift the Scrapbook', 'El yapımı karalama defterini yıldönümünde sürpriz olarak verin.', 'Give the handmade scrapbook as a surprise on the anniversary.', true, 0, 0);

-- Scenario: Second Honeymoon Reveal Anniversary (second-honeymoon-reveal)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1a9d3f27-1d5c-4e01-af43-d78012e8d51f', 1, 'Balayı Destinasyonu Seçimi', 'Choose Honeymoon Destination', 'İkinci balayı için romantik bir destinasyon seçin.', 'Choose a romantic destination for the second honeymoon.', false, 30, 0),
(gen_random_uuid(), '1a9d3f27-1d5c-4e01-af43-d78012e8d51f', 2, 'Uçuş ve Konaklama Rezervasyonu', 'Book Flights and Accommodation', 'Uçak biletlerini ve romantik bir otel rezervasyonu yapın.', 'Book flight tickets and a romantic hotel reservation.', false, 21, 8000),
(gen_random_uuid(), '1a9d3f27-1d5c-4e01-af43-d78012e8d51f', 3, 'Sürpriz Açıklama Materyali Hazırlama', 'Prepare Surprise Reveal Material', 'Biletleri ve planı yaratıcı bir şekilde sunacak materyal hazırlayın.', 'Prepare material to creatively present the tickets and plan.', false, 5, 100),
(gen_random_uuid(), '1a9d3f27-1d5c-4e01-af43-d78012e8d51f', 4, 'Gezi Aktiviteleri Planlama', 'Plan Trip Activities', 'Balayı sırasında yapılacak aktiviteleri araştırın ve planlayın.', 'Research and plan activities for the honeymoon.', true, 10, 0),
(gen_random_uuid(), '1a9d3f27-1d5c-4e01-af43-d78012e8d51f', 5, 'Sürpriz Açıklama Anı', 'Surprise Reveal Moment', 'İkinci balayı sürprizini yaratıcı bir şekilde açıklayın.', 'Reveal the second honeymoon surprise in a creative way.', true, 0, 0);

-- Scenario: Spa Weekend Anniversary Getaway (spa-weekend-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '130db9d4-75a1-4285-9958-4759b0ba4784', 1, 'Spa Oteli Araştırması ve Seçimi', 'Research and Select Spa Hotel', 'Çiftlere özel spa paketleri sunan otelleri araştırın.', 'Research hotels offering couples spa packages.', false, 21, 0),
(gen_random_uuid(), '130db9d4-75a1-4285-9958-4759b0ba4784', 2, 'Otel Rezervasyonu', 'Book Hotel', 'Seçtiğiniz spa otelinde hafta sonu rezervasyonu yapın.', 'Make a weekend reservation at your chosen spa hotel.', false, 14, 3000),
(gen_random_uuid(), '130db9d4-75a1-4285-9958-4759b0ba4784', 3, 'Spa Tedavileri Seçimi', 'Choose Spa Treatments', 'Masaj, yüz bakımı ve diğer tedavileri seçin ve randevu alın.', 'Choose massages, facials, and other treatments and book appointments.', false, 7, 1000),
(gen_random_uuid(), '130db9d4-75a1-4285-9958-4759b0ba4784', 4, 'Bavul Hazırlığı', 'Pack Bags', 'Rahat kıyafetler, mayo ve kişisel bakım ürünlerini hazırlayın.', 'Pack comfortable clothes, swimwear, and personal care products.', true, 1, 0),
(gen_random_uuid(), '130db9d4-75a1-4285-9958-4759b0ba4784', 5, 'Spa Hafta Sonu', 'Spa Weekend', 'Spa otelinde rahatlatıcı bir hafta sonu geçirin.', 'Enjoy a relaxing weekend at the spa hotel.', true, 0, 0);

-- Scenario: Star Map Gift Anniversary (star-map-anniversary-gift)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1074eb40-9cef-442d-964c-605049720d15', 1, 'Özel Tarihi Belirleme', 'Determine Special Date', 'Yıldız haritasının göstereceği özel tarihi ve saati belirleyin.', 'Determine the special date and time the star map will show.', false, 14, 0),
(gen_random_uuid(), '1074eb40-9cef-442d-964c-605049720d15', 2, 'Yıldız Haritası Siparişi', 'Order Star Map', 'Özel tarih ve lokasyona göre yıldız haritasını sipariş edin.', 'Order the star map based on the special date and location.', false, 10, 300),
(gen_random_uuid(), '1074eb40-9cef-442d-964c-605049720d15', 3, 'Çerçeve Seçimi', 'Choose Frame', 'Yıldız haritasına uygun şık bir çerçeve seçin.', 'Choose an elegant frame suitable for the star map.', false, 5, 200),
(gen_random_uuid(), '1074eb40-9cef-442d-964c-605049720d15', 4, 'Kişisel Mesaj Ekleme', 'Add Personal Message', 'Haritanın altına anlamlı bir mesaj veya alıntı ekleyin.', 'Add a meaningful message or quote below the map.', true, 3, 0),
(gen_random_uuid(), '1074eb40-9cef-442d-964c-605049720d15', 5, 'Hediye Sunumu', 'Gift Presentation', 'Yıldız haritasını romantik bir anla hediye edin.', 'Gift the star map at a romantic moment.', true, 0, 0);

-- Scenario: Star Naming Anniversary Surprise (star-naming-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '95da712f-4aae-4eca-9e15-286ae0611759', 1, 'Yıldız Adlandırma Servisi Araştırması', 'Research Star Naming Services', 'Güvenilir yıldız adlandırma servislerini araştırın ve karşılaştırın.', 'Research and compare reliable star naming services.', false, 14, 0),
(gen_random_uuid(), '95da712f-4aae-4eca-9e15-286ae0611759', 2, 'Yıldız Adlandırma Siparişi', 'Order Star Naming', 'Seçtiğiniz yıldıza istediğiniz ismi verin ve sertifika sipariş edin.', 'Name the chosen star and order the certificate.', false, 10, 500),
(gen_random_uuid(), '95da712f-4aae-4eca-9e15-286ae0611759', 3, 'Sertifika ve Hediye Paketi', 'Certificate and Gift Package', 'Yıldız sertifikasını şık bir hediye paketiyle hazırlayın.', 'Prepare the star certificate with an elegant gift package.', false, 3, 50),
(gen_random_uuid(), '95da712f-4aae-4eca-9e15-286ae0611759', 4, 'Yıldız Gözlemi Planı', 'Plan Star Observation', 'Yıldızınızı gökyüzünde bulmak için bir gözlem planı yapın.', 'Make an observation plan to find your star in the sky.', true, 1, 0),
(gen_random_uuid(), '95da712f-4aae-4eca-9e15-286ae0611759', 5, 'Sürpriz Sunum ve Gözlem', 'Surprise Presentation and Observation', 'Sertifikayı hediye edin ve yıldızınızı birlikte gökyüzünde arayın.', 'Gift the certificate and search for your star in the sky together.', true, 0, 0);

-- Scenario: Sunset Cruise Anniversary Celebration (sunset-cruise-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '80b3c79a-8a7a-4963-8ebf-275c9ea89517', 1, 'Tekne Turu Araştırması', 'Research Boat Cruises', 'Gün batımı tekne turları sunan firmaları araştırın.', 'Research companies offering sunset boat cruises.', false, 14, 0),
(gen_random_uuid(), '80b3c79a-8a7a-4963-8ebf-275c9ea89517', 2, 'Tekne Turu Rezervasyonu', 'Book Boat Cruise', 'Özel veya grup tekne turu rezervasyonu yapın.', 'Make a private or group boat cruise reservation.', false, 7, 2000),
(gen_random_uuid(), '80b3c79a-8a7a-4963-8ebf-275c9ea89517', 3, 'Kıyafet ve Hazırlık', 'Outfit and Preparation', 'Tekne turuna uygun şık kıyafetler hazırlayın.', 'Prepare stylish outfits suitable for the boat cruise.', false, 3, 200),
(gen_random_uuid(), '80b3c79a-8a7a-4963-8ebf-275c9ea89517', 4, 'Özel Dokunuşlar Planlama', 'Plan Special Touches', 'Tekne üzerinde çiçek, şampanya veya pasta gibi sürprizler ayarlayın.', 'Arrange surprises like flowers, champagne, or cake on the boat.', true, 2, 500),
(gen_random_uuid(), '80b3c79a-8a7a-4963-8ebf-275c9ea89517', 5, 'Gün Batımı Tekne Turu', 'Sunset Boat Cruise', 'Gün batımını tekne üzerinde izleyerek yıldönümünü kutlayın.', 'Celebrate the anniversary watching the sunset on the boat.', true, 0, 0);

-- Scenario: Private Tango Lesson for Two (tango-lesson-for-two)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '44367a67-37e8-4bf8-adb7-b687533cf12e', 1, 'Tango Okulu Araştırması', 'Research Tango Schools', 'Özel tango dersi veren okulları veya eğitmenleri araştırın.', 'Research schools or instructors offering private tango lessons.', false, 14, 0),
(gen_random_uuid(), '44367a67-37e8-4bf8-adb7-b687533cf12e', 2, 'Ders Rezervasyonu', 'Book the Lesson', 'İkiye özel tango dersi için tarih ve saat belirleyin ve rezerve edin.', 'Set the date and time for a private tango lesson and book it.', false, 7, 800),
(gen_random_uuid(), '44367a67-37e8-4bf8-adb7-b687533cf12e', 3, 'Tango Kıyafetleri Hazırlama', 'Prepare Tango Outfits', 'Tango dansına uygun şık kıyafetler ve ayakkabılar hazırlayın.', 'Prepare elegant clothes and shoes suitable for tango dancing.', false, 3, 300),
(gen_random_uuid(), '44367a67-37e8-4bf8-adb7-b687533cf12e', 4, 'Sürpriz Açıklama', 'Reveal the Surprise', 'Dans dersi sürprizini yaratıcı bir şekilde açıklayın.', 'Reveal the dance lesson surprise in a creative way.', true, 1, 0),
(gen_random_uuid(), '44367a67-37e8-4bf8-adb7-b687533cf12e', 5, 'Tango Dersi', 'Tango Lesson', 'Birlikte tango öğrenin ve tutkulu bir dans deneyimi yaşayın.', 'Learn tango together and experience a passionate dance.', true, 0, 0);

-- Scenario: Time Capsule Reveal Celebration (time-capsule-reveal)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '772025f6-46df-44fe-9f74-48c0dd58d2c3', 1, 'Zaman Kapsülünü Bulma', 'Locate the Time Capsule', 'Daha önce saklanan zaman kapsülünün yerini belirleyin.', 'Locate the previously hidden time capsule.', false, 7, 0),
(gen_random_uuid(), '772025f6-46df-44fe-9f74-48c0dd58d2c3', 2, 'Açılış Töreni Planlama', 'Plan Opening Ceremony', 'Kapsülün açılış töreninin detaylarını planlayın.', 'Plan the details of the capsule opening ceremony.', false, 5, 0),
(gen_random_uuid(), '772025f6-46df-44fe-9f74-48c0dd58d2c3', 3, 'Kutlama Ortamı Hazırlama', 'Prepare Celebration Setting', 'Açılış için özel bir ortam hazırlayın: mumlar, müzik ve ikramlar.', 'Prepare a special setting for the opening: candles, music, and treats.', false, 2, 200),
(gen_random_uuid(), '772025f6-46df-44fe-9f74-48c0dd58d2c3', 4, 'Yeni Kapsül Materyalleri', 'New Capsule Materials', 'Yeni bir zaman kapsülü için taze materyaller hazırlayın.', 'Prepare fresh materials for a new time capsule.', true, 1, 50),
(gen_random_uuid(), '772025f6-46df-44fe-9f74-48c0dd58d2c3', 5, 'Kapsülü Açma ve Kutlama', 'Open Capsule and Celebrate', 'Kapsülü birlikte açın, anıları okuyun ve yeni bir kapsül hazırlayın.', 'Open the capsule together, read the memories, and prepare a new one.', true, 0, 0);

-- Scenario: 12-Hour Surprise Marathon (twelve-hour-surprise-marathon)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '530ac437-e264-4594-af32-efedb426b477', 1, '12 Saatlik Program Planlama', 'Plan 12-Hour Schedule', 'Sabahtan geceye kadar her saat için farklı bir sürpriz planlayın.', 'Plan a different surprise for each hour from morning to night.', false, 14, 0),
(gen_random_uuid(), '530ac437-e264-4594-af32-efedb426b477', 2, 'Sürpriz Malzemeleri ve Rezervasyonlar', 'Supplies and Reservations for Surprises', 'Her sürpriz için gerekli malzemeleri alın ve rezervasyonları yapın.', 'Get necessary supplies for each surprise and make reservations.', false, 7, 2000),
(gen_random_uuid(), '530ac437-e264-4594-af32-efedb426b477', 3, 'Yardımcı Ekip Koordinasyonu', 'Helper Team Coordination', 'Sürprizlerde yardım edecek arkadaşları organize edin.', 'Organize friends who will help with the surprises.', false, 3, 0),
(gen_random_uuid(), '530ac437-e264-4594-af32-efedb426b477', 4, 'Son Kontrol ve Provalar', 'Final Check and Rehearsals', 'Tüm sürprizlerin detaylarını son kez gözden geçirin.', 'Review all surprise details one final time.', true, 1, 0),
(gen_random_uuid(), '530ac437-e264-4594-af32-efedb426b477', 5, 'Maraton Günü', 'Marathon Day', '12 saatlik sürpriz maratonunu başlatın ve her anın tadını çıkarın.', 'Start the 12-hour surprise marathon and enjoy every moment.', true, 0, 0);

-- Scenario: Vintage Photo Shoot Anniversary (vintage-photo-shoot)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9920c7bf-77ab-407a-be9c-f044acee6c47', 1, 'Vintage Tema ve Dönem Seçimi', 'Choose Vintage Theme and Era', 'Hangi döneme ait bir çekim yapılacağını belirleyin (50''''ler, 60''''lar vb.).', 'Determine which era the shoot will represent (50s, 60s, etc.).', false, 14, 0),
(gen_random_uuid(), '9920c7bf-77ab-407a-be9c-f044acee6c47', 2, 'Kostüm ve Aksesuar Tedariki', 'Procure Costumes and Accessories', 'Döneme uygun kıyafetler, şapkalar ve aksesuarlar kiralayın veya satın alın.', 'Rent or buy era-appropriate clothes, hats, and accessories.', false, 7, 600),
(gen_random_uuid(), '9920c7bf-77ab-407a-be9c-f044acee6c47', 3, 'Fotoğrafçı ve Mekan Ayarlama', 'Arrange Photographer and Venue', 'Vintage çekim konusunda deneyimli bir fotoğrafçı ve mekan ayarlayın.', 'Arrange a photographer experienced in vintage shoots and a venue.', false, 5, 1000),
(gen_random_uuid(), '9920c7bf-77ab-407a-be9c-f044acee6c47', 4, 'Saç ve Makyaj Hazırlığı', 'Hair and Makeup Preparation', 'Döneme uygun saç ve makyaj için randevu alın.', 'Book appointments for era-appropriate hair and makeup.', true, 2, 300),
(gen_random_uuid(), '9920c7bf-77ab-407a-be9c-f044acee6c47', 5, 'Fotoğraf Çekimi Günü', 'Photo Shoot Day', 'Vintage kıyafetlerle muhteşem fotoğraflar çektirin.', 'Have amazing photos taken in vintage outfits.', true, 0, 0);

-- Scenario: Vinyl Record Guestbook Anniversary (vinyl-guestbook-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '550d86e9-b565-436e-909e-f0cd123e0a38', 1, 'Vinil Plak ve Malzeme Tedariki', 'Procure Vinyl Record and Supplies', 'Boş veya eski bir vinil plak ve özel kalemler satın alın.', 'Purchase a blank or old vinyl record and special markers.', false, 10, 150),
(gen_random_uuid(), '550d86e9-b565-436e-909e-f0cd123e0a38', 2, 'Misafir Listesi Hazırlama', 'Prepare Guest List', 'Yıldönümü partisine gelecek misafirlerin listesini oluşturun.', 'Create a list of guests coming to the anniversary party.', false, 7, 0),
(gen_random_uuid(), '550d86e9-b565-436e-909e-f0cd123e0a38', 3, 'Plak Standı ve Süsleme', 'Record Stand and Decoration', 'Vinil plağı sergilemek için bir stand hazırlayın ve süsleyin.', 'Prepare a stand to display the vinyl record and decorate it.', false, 3, 100),
(gen_random_uuid(), '550d86e9-b565-436e-909e-f0cd123e0a38', 4, 'Yazı Alanı Düzenleme', 'Set Up Writing Area', 'Partide misafirlerin yazabilmesi için bir köşe hazırlayın.', 'Set up a corner at the party where guests can write.', true, 0, 50),
(gen_random_uuid(), '550d86e9-b565-436e-909e-f0cd123e0a38', 5, 'Plağı Sergileme', 'Display the Record', 'Mesajlarla dolu vinil plağı özel bir yere asarak sergileyin.', 'Display the vinyl record filled with messages by hanging it in a special place.', true, 0, 0);

-- Scenario: Wine Tasting Anniversary Experience (wine-tasting-anniversary)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9c838973-14fd-4444-9e70-085ecdfd06f6', 1, 'Şarap Tadım Mekanı Araştırması', 'Research Wine Tasting Venues', 'Çiftlere özel şarap tadım deneyimi sunan mekanları araştırın.', 'Research venues offering wine tasting experiences for couples.', false, 14, 0),
(gen_random_uuid(), '9c838973-14fd-4444-9e70-085ecdfd06f6', 2, 'Rezervasyon Yapma', 'Make Reservation', 'Şarap tadım etkinliği için tarih ve saat belirleyerek rezervasyon yapın.', 'Book the wine tasting event by setting a date and time.', false, 7, 1000),
(gen_random_uuid(), '9c838973-14fd-4444-9e70-085ecdfd06f6', 3, 'Ulaşım Planlaması', 'Plan Transportation', 'Şarap tadımı sonrası güvenli ulaşım için plan yapın.', 'Plan safe transportation for after the wine tasting.', false, 3, 200),
(gen_random_uuid(), '9c838973-14fd-4444-9e70-085ecdfd06f6', 4, 'Şarap Bilgisi Araştırma', 'Research Wine Knowledge', 'Temel şarap bilgisi ve tadım kurallarını öğrenin.', 'Learn basic wine knowledge and tasting rules.', true, 5, 0),
(gen_random_uuid(), '9c838973-14fd-4444-9e70-085ecdfd06f6', 5, 'Şarap Tadım Deneyimi', 'Wine Tasting Experience', 'Birlikte farklı şarapları tadın ve şarap kültürünü keşfedin.', 'Taste different wines together and discover wine culture.', true, 0, 0);

-- Scenario: 365 Reasons Why I Love You Jar (365-reasons-jar)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3b92092c-5c7b-4063-8e0d-64a729b69548', 1, 'Kavanoz ve Malzeme Seçimi', 'Choose Jar and Materials', 'Güzel bir kavanoz ve 365 adet renkli kağıt satın alın.', 'Purchase a beautiful jar and 365 colorful papers.', false, 30, 100),
(gen_random_uuid(), '3b92092c-5c7b-4063-8e0d-64a729b69548', 2, 'Nedenleri Yazma', 'Write the Reasons', '365 farklı sevgi nedeni ve güzel özellik yazın.', 'Write 365 different love reasons and beautiful qualities.', false, 21, 0),
(gen_random_uuid(), '3b92092c-5c7b-4063-8e0d-64a729b69548', 3, 'Kağıtları Katlayıp Yerleştirme', 'Fold and Place Papers', 'Tüm kağıtları güzelce katlayın ve kavanoza yerleştirin.', 'Neatly fold all papers and place them in the jar.', false, 7, 0),
(gen_random_uuid(), '3b92092c-5c7b-4063-8e0d-64a729b69548', 4, 'Kavanoz Süsleme', 'Decorate the Jar', 'Kavanozu kurdeleler, etiket ve süslemelerle dekore edin.', 'Decorate the jar with ribbons, labels, and ornaments.', true, 3, 50),
(gen_random_uuid(), '3b92092c-5c7b-4063-8e0d-64a729b69548', 5, 'Kavanozu Hediye Etme', 'Gift the Jar', 'Kavanozu samimi bir şekilde sunarak özür dileyin.', 'Present the jar sincerely as an apology.', true, 0, 0);

-- Scenario: Balloon-Filled Room Apology (balloon-room-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8feeef08-9000-4313-b3bd-ae1de5d9c059', 1, 'Balon ve Malzeme Satın Alma', 'Purchase Balloons and Supplies', 'Yüzlerce renkli balon ve helyum tüpü satın alın.', 'Purchase hundreds of colorful balloons and a helium tank.', false, 3, 400),
(gen_random_uuid(), '8feeef08-9000-4313-b3bd-ae1de5d9c059', 2, 'Özür Mesajları Hazırlama', 'Prepare Apology Messages', 'Balonların içine küçük özür notları ve sevgi mesajları koyun.', 'Place small apology notes and love messages inside the balloons.', false, 2, 0),
(gen_random_uuid(), '8feeef08-9000-4313-b3bd-ae1de5d9c059', 3, 'Balonları Şişirme', 'Inflate Balloons', 'Tüm balonları şişirin ve odayı doldurmak için hazırlayın.', 'Inflate all balloons and prepare them to fill the room.', false, 0, 0),
(gen_random_uuid(), '8feeef08-9000-4313-b3bd-ae1de5d9c059', 4, 'Odayı Balonlarla Doldurma', 'Fill Room with Balloons', 'Kişi gelmeden önce odayı balonlarla tamamen doldurun.', 'Fill the room completely with balloons before the person arrives.', true, 0, 0),
(gen_random_uuid(), '8feeef08-9000-4313-b3bd-ae1de5d9c059', 5, 'Sürpriz Anı', 'Surprise Moment', 'Kişi kapıyı açtığında balonlarla karşılasın ve özür notlarını bulsun.', 'When the person opens the door, greet them with balloons and apology notes.', true, 0, 0);

-- Scenario: Breakfast in Bed Apology (breakfast-bed-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '692e7542-627e-4c69-acba-441f2bd2fe3a', 1, 'Menü Planlama', 'Plan the Menu', 'Kişinin en sevdiği kahvaltı yiyeceklerinden bir menü oluşturun.', 'Create a menu from the person''''s favorite breakfast foods.', false, 2, 0),
(gen_random_uuid(), '692e7542-627e-4c69-acba-441f2bd2fe3a', 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Kahvaltı malzemelerini, taze meyve ve çiçek satın alın.', 'Purchase breakfast ingredients, fresh fruit, and flowers.', false, 1, 200),
(gen_random_uuid(), '692e7542-627e-4c69-acba-441f2bd2fe3a', 3, 'Kahvaltı Hazırlama', 'Prepare Breakfast', 'Sabah erken kalkın ve kahvaltıyı özenle hazırlayın.', 'Wake up early and carefully prepare the breakfast.', false, 0, 0),
(gen_random_uuid(), '692e7542-627e-4c69-acba-441f2bd2fe3a', 4, 'Tepsi ve Sunum Düzenleme', 'Arrange Tray and Presentation', 'Kahvaltıyı güzel bir tepside düzenleyin, çiçek ve kart ekleyin.', 'Arrange breakfast on a beautiful tray, add flowers and a card.', true, 0, 30),
(gen_random_uuid(), '692e7542-627e-4c69-acba-441f2bd2fe3a', 5, 'Yatağa Servis', 'Serve in Bed', 'Kahvaltıyı yatağa götürün ve samimi bir özür dileyin.', 'Bring breakfast to bed and offer a sincere apology.', true, 0, 0);

-- Scenario: Candlelight Dinner Apology (candlelight-dinner-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e1d39527-2ea9-4d33-9260-20c830de3f9d', 1, 'Menü ve Mekan Planlaması', 'Plan Menu and Venue', 'Özür yemeği için özel bir menü ve romantik mekan planlayın.', 'Plan a special menu and romantic venue for the apology dinner.', false, 5, 0),
(gen_random_uuid(), 'e1d39527-2ea9-4d33-9260-20c830de3f9d', 2, 'Malzeme ve Dekorasyon Alışverişi', 'Shop for Supplies and Decoration', 'Yemek malzemeleri, mumlar, çiçekler ve masa süsleri alın.', 'Buy food ingredients, candles, flowers, and table decorations.', false, 3, 400),
(gen_random_uuid(), 'e1d39527-2ea9-4d33-9260-20c830de3f9d', 3, 'Yemek Hazırlama', 'Prepare the Meal', 'Menüdeki yemekleri özenle pişirin.', 'Carefully cook the dishes on the menu.', false, 0, 0),
(gen_random_uuid(), 'e1d39527-2ea9-4d33-9260-20c830de3f9d', 4, 'Romantik Ortam Oluşturma', 'Create Romantic Atmosphere', 'Masayı kurun, mumları yakın ve romantik müzik açın.', 'Set the table, light the candles, and play romantic music.', true, 0, 0),
(gen_random_uuid(), 'e1d39527-2ea9-4d33-9260-20c830de3f9d', 5, 'Özür Yemeği', 'Apology Dinner', 'Mum ışığında yemek yiyin ve samimi bir özür konuşması yapın.', 'Dine by candlelight and have a sincere apology conversation.', true, 0, 0);

-- Scenario: Charity Donation Apology (charity-donation-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd666ee76-c472-463d-a896-e0f201e39b3d', 1, 'Hayır Kurumu Seçimi', 'Choose Charity', 'Kişinin önemsediği bir konuda çalışan hayır kurumunu seçin.', 'Choose a charity working on a cause the person cares about.', false, 5, 0),
(gen_random_uuid(), 'd666ee76-c472-463d-a896-e0f201e39b3d', 2, 'Bağış Miktarı Belirleme', 'Determine Donation Amount', 'Anlamlı bir bağış miktarı belirleyin.', 'Determine a meaningful donation amount.', false, 3, 0),
(gen_random_uuid(), 'd666ee76-c472-463d-a896-e0f201e39b3d', 3, 'Bağışı Gerçekleştirme', 'Make the Donation', 'Seçilen hayır kurumuna bağışı yapın ve makbuzu alın.', 'Make the donation to the chosen charity and get the receipt.', false, 1, 1000),
(gen_random_uuid(), 'd666ee76-c472-463d-a896-e0f201e39b3d', 4, 'Bağış Sertifikası Hazırlama', 'Prepare Donation Certificate', 'Bağış belgesini çerçeveletin veya özel bir sunumla hazırlayın.', 'Frame the donation document or prepare it with a special presentation.', true, 1, 50),
(gen_random_uuid(), 'd666ee76-c472-463d-a896-e0f201e39b3d', 5, 'Sertifikayı Sunma', 'Present the Certificate', 'Bağış sertifikasını özürle birlikte kişiye sunun.', 'Present the donation certificate along with your apology.', true, 0, 0);

-- Scenario: Cooking an Apology Dinner (cooking-dinner-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6a6818c8-65d5-4550-8243-cb5a775d12d2', 1, 'Tarif Seçimi', 'Choose Recipe', 'Kişinin en sevdiği yemeğin tarifini araştırın ve seçin.', 'Research and choose the recipe for the person''''s favorite dish.', false, 3, 0),
(gen_random_uuid(), '6a6818c8-65d5-4550-8243-cb5a775d12d2', 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Tarif için gerekli tüm malzemeleri taze olarak satın alın.', 'Purchase all fresh ingredients needed for the recipe.', false, 1, 300),
(gen_random_uuid(), '6a6818c8-65d5-4550-8243-cb5a775d12d2', 3, 'Yemek Pişirme', 'Cook the Meal', 'Yemeği özenle ve sevgiyle pişirin.', 'Cook the meal with care and love.', false, 0, 0),
(gen_random_uuid(), '6a6818c8-65d5-4550-8243-cb5a775d12d2', 4, 'Masa Düzenleme', 'Set the Table', 'Masayı özel bir şekilde kurun, çiçek ve mum ekleyin.', 'Set the table specially, add flowers and candles.', true, 0, 100),
(gen_random_uuid(), '6a6818c8-65d5-4550-8243-cb5a775d12d2', 5, 'Yemeği Sunma ve Özür Dileme', 'Serve Dinner and Apologize', 'Yemeği sunun ve yemek sırasında içtenlikle özür dileyin.', 'Serve the dinner and sincerely apologize during the meal.', true, 0, 0);

-- Scenario: Couples Therapy Surprise (couples-therapy-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f3d459dc-de8f-45cf-a53a-4097d7f46bc8', 1, 'Terapist Araştırması', 'Research Therapists', 'Çift terapisi konusunda uzman terapistleri araştırın.', 'Research therapists specializing in couples therapy.', false, 14, 0),
(gen_random_uuid(), 'f3d459dc-de8f-45cf-a53a-4097d7f46bc8', 2, 'Randevu Alma', 'Book Appointment', 'Uygun bir terapistle ilk randevuyu alın.', 'Book the first appointment with a suitable therapist.', false, 7, 500),
(gen_random_uuid(), 'f3d459dc-de8f-45cf-a53a-4097d7f46bc8', 3, 'Kendi Düşüncelerinizi Düzenleme', 'Organize Your Thoughts', 'Terapide konuşmak istediğiniz konuları ve duygularınızı yazın.', 'Write down topics and feelings you want to discuss in therapy.', false, 3, 0),
(gen_random_uuid(), 'f3d459dc-de8f-45cf-a53a-4097d7f46bc8', 4, 'Teklifi Hazırlama', 'Prepare the Proposal', 'Terapi önerisini nazik ve yapıcı bir şekilde sunmaya hazırlanın.', 'Prepare to present the therapy suggestion gently and constructively.', true, 1, 0),
(gen_random_uuid(), 'f3d459dc-de8f-45cf-a53a-4097d7f46bc8', 5, 'Terapi Önerisini Sunma', 'Present the Therapy Suggestion', 'Terapiye gitme önerisini saygılı ve sevgi dolu bir şekilde sunun.', 'Present the suggestion to attend therapy respectfully and lovingly.', true, 0, 0);

-- Scenario: Custom Cake Apology (custom-cake-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '910bc265-4999-4e0e-bceb-c38e9ea574f8', 1, 'Pasta Tasarımı Belirleme', 'Determine Cake Design', 'Özür mesajlı özel pasta tasarımını ve aromasını belirleyin.', 'Determine the custom cake design with apology message and flavor.', false, 5, 0),
(gen_random_uuid(), '910bc265-4999-4e0e-bceb-c38e9ea574f8', 2, 'Pastane Siparişi', 'Bakery Order', 'Özel tasarım pastayı güvenilir bir pastaneden sipariş edin.', 'Order the custom-designed cake from a reliable bakery.', false, 3, 400),
(gen_random_uuid(), '910bc265-4999-4e0e-bceb-c38e9ea574f8', 3, 'Pasta Teslim Alımı', 'Pick Up the Cake', 'Pastayı zamanında teslim alın ve sürpriz anına kadar saklayın.', 'Pick up the cake on time and keep it hidden until the surprise.', false, 0, 0),
(gen_random_uuid(), '910bc265-4999-4e0e-bceb-c38e9ea574f8', 4, 'Sunum Hazırlığı', 'Prepare Presentation', 'Pastayı sunacağınız ortamı hazırlayın, mumlar ve tabaklar koyun.', 'Prepare the setting where you will present the cake with candles and plates.', true, 0, 50),
(gen_random_uuid(), '910bc265-4999-4e0e-bceb-c38e9ea574f8', 5, 'Pasta Sürprizi ve Özür', 'Cake Surprise and Apology', 'Pastayı çıkarın, özür mesajını okuyun ve birlikte tadın.', 'Reveal the cake, read the apology message, and enjoy it together.', true, 0, 0);

-- Scenario: Explosion Box of Memories (explosion-box-memories)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd5cc8ff4-1101-4fd9-b8b6-e031ac431540', 1, 'Patlayan Kutu Malzemeleri Tedariki', 'Procure Explosion Box Supplies', 'Karton, fotoğraflar, süsleme malzemeleri ve yapıştırıcı satın alın.', 'Purchase cardboard, photos, decoration materials, and glue.', false, 7, 150),
(gen_random_uuid(), 'd5cc8ff4-1101-4fd9-b8b6-e031ac431540', 2, 'Kutu Yapısını Oluşturma', 'Build Box Structure', 'Patlayan kutunun açılan katmanlarını kesin ve katlayın.', 'Cut and fold the opening layers of the explosion box.', false, 5, 0),
(gen_random_uuid(), 'd5cc8ff4-1101-4fd9-b8b6-e031ac431540', 3, 'Fotoğraf ve Anıları Yerleştirme', 'Place Photos and Memories', 'Her katmana anlamlı fotoğraflar ve anı objeleri yerleştirin.', 'Place meaningful photos and memorabilia on each layer.', false, 3, 0),
(gen_random_uuid(), 'd5cc8ff4-1101-4fd9-b8b6-e031ac431540', 4, 'Mesaj ve Süsleme Ekleme', 'Add Messages and Decorations', 'Özür ve sevgi mesajları yazın, kutuyu süsleyin.', 'Write apology and love messages, decorate the box.', true, 1, 0),
(gen_random_uuid(), 'd5cc8ff4-1101-4fd9-b8b6-e031ac431540', 5, 'Kutuyu Hediye Etme', 'Gift the Box', 'Patlayan anı kutusunu sürpriz olarak hediye edin.', 'Gift the explosion memory box as a surprise.', true, 0, 0);

-- Scenario: Flower Bomb Apology (flower-bomb-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '939814fe-d1a9-4d36-91b7-6925d63a0a3a', 1, 'Çiçek Türleri ve Miktarı Belirleme', 'Determine Flower Types and Quantity', 'Kişinin en sevdiği çiçekleri ve gerekli miktarı belirleyin.', 'Determine the person''''s favorite flowers and required quantity.', false, 5, 0),
(gen_random_uuid(), '939814fe-d1a9-4d36-91b7-6925d63a0a3a', 2, 'Çiçek Siparişi Verme', 'Place Flower Order', 'Büyük miktarda çiçeği çiçekçiden sipariş edin.', 'Order a large quantity of flowers from a florist.', false, 3, 800),
(gen_random_uuid(), '939814fe-d1a9-4d36-91b7-6925d63a0a3a', 3, 'Teslimat Planlaması', 'Plan Delivery', 'Çiçeklerin teslimat zamanını ve şeklini planlayın.', 'Plan the delivery time and method for the flowers.', false, 1, 0),
(gen_random_uuid(), '939814fe-d1a9-4d36-91b7-6925d63a0a3a', 4, 'Özür Kartı Hazırlama', 'Prepare Apology Card', 'Çiçeklerle birlikte gönderilecek duygusal bir özür kartı yazın.', 'Write an emotional apology card to be sent with the flowers.', true, 1, 20),
(gen_random_uuid(), '939814fe-d1a9-4d36-91b7-6925d63a0a3a', 5, 'Çiçek Bombardımanı', 'Flower Bomb Delivery', 'Çiçekleri sürpriz olarak teslim ettirin ve tepkiyi bekleyin.', 'Have the flowers delivered as a surprise and await the reaction.', true, 0, 0);

-- Scenario: Forgiveness Jar (forgiveness-jar)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7515d8fa-798f-4530-8a0d-d8e2682a3df3', 1, 'Kavanoz Seçimi', 'Choose the Jar', 'Anlamlı ve güzel bir cam kavanoz satın alın.', 'Purchase a meaningful and beautiful glass jar.', false, 5, 80),
(gen_random_uuid(), '7515d8fa-798f-4530-8a0d-d8e2682a3df3', 2, 'Affetme Kartları Hazırlama', 'Prepare Forgiveness Cards', 'Farklı renklerde kartlar hazırlayın: pişmanlıklar, vaatler ve güzel anılar.', 'Prepare cards in different colors: regrets, promises, and beautiful memories.', false, 3, 30),
(gen_random_uuid(), '7515d8fa-798f-4530-8a0d-d8e2682a3df3', 3, 'Kartlara Yazma', 'Write on Cards', 'Her karta samimi ve düşünceli mesajlar yazın.', 'Write sincere and thoughtful messages on each card.', false, 2, 0),
(gen_random_uuid(), '7515d8fa-798f-4530-8a0d-d8e2682a3df3', 4, 'Kavanozu Süsleme', 'Decorate the Jar', 'Kavanozu kurdeleler ve anlamlı bir etiketle süsleyin.', 'Decorate the jar with ribbons and a meaningful label.', true, 1, 20),
(gen_random_uuid(), '7515d8fa-798f-4530-8a0d-d8e2682a3df3', 5, 'Kavanozu Sunma', 'Present the Jar', 'Affetme kavanozunu samimi bir konuşmayla birlikte sunun.', 'Present the forgiveness jar along with a sincere conversation.', true, 0, 0);

-- Scenario: Garden Plant Apology (garden-plant-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7fbccb60-179a-4c37-af21-3578c22f0d54', 1, 'Bitki Türü Seçimi', 'Choose Plant Type', 'Kişinin seveceği ve bakımı kolay bir bitki türü seçin.', 'Choose a plant species the person will love and is easy to care for.', false, 5, 0),
(gen_random_uuid(), '7fbccb60-179a-4c37-af21-3578c22f0d54', 2, 'Bitki ve Saksı Satın Alma', 'Purchase Plant and Pot', 'Seçilen bitkiyi ve dekoratif bir saksıyı satın alın.', 'Purchase the chosen plant and a decorative pot.', false, 3, 200),
(gen_random_uuid(), '7fbccb60-179a-4c37-af21-3578c22f0d54', 3, 'Kişiselleştirme', 'Personalization', 'Saksıya özel bir mesaj veya isim yazdırın.', 'Have a special message or name written on the pot.', false, 2, 50),
(gen_random_uuid(), '7fbccb60-179a-4c37-af21-3578c22f0d54', 4, 'Bakım Kartı Hazırlama', 'Prepare Care Card', 'Bitkinin bakım talimatlarını ve sembolik anlamını içeren bir kart yazın.', 'Write a card with the plant''''s care instructions and symbolic meaning.', true, 1, 0),
(gen_random_uuid(), '7fbccb60-179a-4c37-af21-3578c22f0d54', 5, 'Bitkiyi Hediye Etme', 'Gift the Plant', 'Bitkiyi özür mesajıyla birlikte hediye edin.', 'Gift the plant along with an apology message.', true, 0, 0);

-- Scenario: Handwritten Letter Series (handwritten-letter-series)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f7b8ac1f-34fd-40fb-969e-4cfb84a7475a', 1, 'Mektup Konularını Belirleme', 'Determine Letter Topics', 'Her mektubun konusunu belirleyin: özür, anılar, gelecek vaatleri vb.', 'Determine each letter''''s topic: apology, memories, future promises, etc.', false, 7, 0),
(gen_random_uuid(), 'f7b8ac1f-34fd-40fb-969e-4cfb84a7475a', 2, 'Özel Kağıt ve Kalem Tedariki', 'Procure Special Paper and Pen', 'Kaliteli mektup kağıdı, zarflar ve güzel bir kalem satın alın.', 'Purchase quality letter paper, envelopes, and a beautiful pen.', false, 5, 100),
(gen_random_uuid(), 'f7b8ac1f-34fd-40fb-969e-4cfb84a7475a', 3, 'Mektupları Yazma', 'Write the Letters', 'Her mektubu el yazısıyla samimi ve düşünceli bir şekilde yazın.', 'Write each letter by hand sincerely and thoughtfully.', false, 3, 0),
(gen_random_uuid(), 'f7b8ac1f-34fd-40fb-969e-4cfb84a7475a', 4, 'Zarflama ve Numaralama', 'Envelope and Number', 'Mektupları zarflayın ve okunma sırasına göre numaralayın.', 'Seal the letters in envelopes and number them in reading order.', true, 1, 0),
(gen_random_uuid(), 'f7b8ac1f-34fd-40fb-969e-4cfb84a7475a', 5, 'Mektup Serisini Sunma', 'Present the Letter Series', 'Mektup serisini özel bir kutuyla birlikte hediye edin.', 'Gift the letter series along with a special box.', true, 0, 30);

-- Scenario: Heartfelt Apology Surprise (heartfelt-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000010-0001-0001-0001-000000000001', 1, 'Özür Planı Oluşturma', 'Create Apology Plan', 'Samimi bir özür için ne söyleyeceğinizi ve nasıl söyleyeceğinizi planlayın.', 'Plan what you will say and how you will say it for a sincere apology.', false, 3, 0),
(gen_random_uuid(), 'a0000010-0001-0001-0001-000000000001', 2, 'Hediye veya Jest Hazırlığı', 'Prepare Gift or Gesture', 'Özrünüzü destekleyecek küçük ama anlamlı bir hediye hazırlayın.', 'Prepare a small but meaningful gift to support your apology.', false, 2, 200),
(gen_random_uuid(), 'a0000010-0001-0001-0001-000000000001', 3, 'Ortam Hazırlığı', 'Prepare the Setting', 'Sakin ve özel bir ortam oluşturun: temiz ev, güzel koku, düzen.', 'Create a calm and private setting: clean home, nice scent, order.', false, 1, 50),
(gen_random_uuid(), 'a0000010-0001-0001-0001-000000000001', 4, 'Özür Mektubu Yazma', 'Write Apology Letter', 'Duygularınızı ve pişmanlığınızı anlatan samimi bir mektup yazın.', 'Write a sincere letter expressing your feelings and regret.', true, 1, 0),
(gen_random_uuid(), 'a0000010-0001-0001-0001-000000000001', 5, 'Özür Anı', 'Apology Moment', 'Yüz yüze samimi bir şekilde özür dileyin ve hediyeyi sunun.', 'Apologize sincerely face to face and present the gift.', true, 0, 0);

-- Scenario: Love Jar Apology (love-jar-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '657ffa58-28e7-45ed-95f9-d08dfd0fddd1', 1, 'Kavanoz ve Malzeme Seçimi', 'Choose Jar and Supplies', 'Dekoratif bir kavanoz ve renkli kağıtlar satın alın.', 'Purchase a decorative jar and colorful papers.', false, 5, 80),
(gen_random_uuid(), '657ffa58-28e7-45ed-95f9-d08dfd0fddd1', 2, 'Sevgi Mesajları Yazma', 'Write Love Messages', 'En az 50 farklı sevgi mesajı ve güzel anı yazın.', 'Write at least 50 different love messages and beautiful memories.', false, 3, 0),
(gen_random_uuid(), '657ffa58-28e7-45ed-95f9-d08dfd0fddd1', 3, 'Mesajları Katlayıp Yerleştirme', 'Fold and Place Messages', 'Mesajları katlayın ve kavanoza yerleştirin.', 'Fold the messages and place them in the jar.', false, 1, 0),
(gen_random_uuid(), '657ffa58-28e7-45ed-95f9-d08dfd0fddd1', 4, 'Kavanoz Dekorasyonu', 'Jar Decoration', 'Kavanozu kurdeleler ve özür temalı etiketle süsleyin.', 'Decorate the jar with ribbons and an apology-themed label.', true, 1, 30),
(gen_random_uuid(), '657ffa58-28e7-45ed-95f9-d08dfd0fddd1', 5, 'Kavanozu Hediye Etme', 'Gift the Jar', 'Sevgi kavanozunu özürle birlikte sunun.', 'Present the love jar along with your apology.', true, 0, 0);

-- Scenario: Love Letter Bouquet Apology (love-letter-bouquet)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0b6209bc-95d2-4c30-baa6-2ffbdc3c1dc0', 1, 'Mektup ve Çiçek Seçimi', 'Choose Letters and Flowers', 'Küçük mektuplar ve buket için çiçek türlerini belirleyin.', 'Determine small letters and flower types for the bouquet.', false, 5, 0),
(gen_random_uuid(), '0b6209bc-95d2-4c30-baa6-2ffbdc3c1dc0', 2, 'Mektupları Yazma', 'Write the Letters', 'Her çiçeğe bağlanacak küçük özür ve sevgi mektupları yazın.', 'Write small apology and love letters to be attached to each flower.', false, 3, 0),
(gen_random_uuid(), '0b6209bc-95d2-4c30-baa6-2ffbdc3c1dc0', 3, 'Çiçek Buketi Siparişi', 'Order Flower Bouquet', 'Güzel bir çiçek buketi sipariş edin.', 'Order a beautiful flower bouquet.', false, 2, 300),
(gen_random_uuid(), '0b6209bc-95d2-4c30-baa6-2ffbdc3c1dc0', 4, 'Mektupları Çiçeklere Bağlama', 'Attach Letters to Flowers', 'Her mektubu kurdelelerle çiçeklere bağlayın.', 'Attach each letter to the flowers with ribbons.', true, 0, 20),
(gen_random_uuid(), '0b6209bc-95d2-4c30-baa6-2ffbdc3c1dc0', 5, 'Buketi Sunma', 'Present the Bouquet', 'Mektup buketini sürpriz olarak sunun ve birlikte okuyun.', 'Present the letter bouquet as a surprise and read them together.', true, 0, 0);

-- Scenario: Memory Video Apology (memory-video-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0fa19584-1165-42e1-8f5b-fce30562db8e', 1, 'Video Materyalleri Toplama', 'Collect Video Materials', 'Birlikte olduğunuz güzel anların fotoğraf ve videolarını toplayın.', 'Collect photos and videos of beautiful moments you shared.', false, 7, 0),
(gen_random_uuid(), '0fa19584-1165-42e1-8f5b-fce30562db8e', 2, 'Senaryo ve Akış Hazırlama', 'Prepare Script and Flow', 'Videonun akışını planlayın: güzel anılar ve özür mesajı.', 'Plan the video flow: beautiful memories and apology message.', false, 5, 0),
(gen_random_uuid(), '0fa19584-1165-42e1-8f5b-fce30562db8e', 3, 'Video Düzenleme', 'Edit the Video', 'Fotoğrafları ve videoları bir araya getirerek duygusal bir montaj yapın.', 'Create an emotional montage combining photos and videos.', false, 3, 0),
(gen_random_uuid(), '0fa19584-1165-42e1-8f5b-fce30562db8e', 4, 'Müzik ve Mesaj Ekleme', 'Add Music and Message', 'Anlamlı bir müzik ve kişisel özür mesajı ekleyin.', 'Add a meaningful song and personal apology message.', true, 1, 0),
(gen_random_uuid(), '0fa19584-1165-42e1-8f5b-fce30562db8e', 5, 'Videoyu Gösterme', 'Show the Video', 'Videoyu özel bir anda birlikte izleyin.', 'Watch the video together at a special moment.', true, 0, 0);

-- Scenario: Message Chain Apology (message-chain-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '75215d40-923e-43f8-b2eb-1c3c74148d3a', 1, 'Mesaj İçerikleri Planlama', 'Plan Message Contents', 'Gün boyunca gönderilecek mesajların içeriklerini planlayın.', 'Plan the contents of messages to be sent throughout the day.', false, 3, 0),
(gen_random_uuid(), '75215d40-923e-43f8-b2eb-1c3c74148d3a', 2, 'Mesaj Zamanlaması Belirleme', 'Determine Message Timing', 'Her mesajın gönderileceği saati ve sırayı belirleyin.', 'Determine the time and order for sending each message.', false, 2, 0),
(gen_random_uuid(), '75215d40-923e-43f8-b2eb-1c3c74148d3a', 3, 'Mesajları Yazma', 'Write the Messages', 'Her mesajı samimi ve düşünceli bir şekilde kaleme alın.', 'Write each message sincerely and thoughtfully.', false, 1, 0),
(gen_random_uuid(), '75215d40-923e-43f8-b2eb-1c3c74148d3a', 4, 'Final Sürprizi Hazırlama', 'Prepare Final Surprise', 'Son mesajla birlikte bir buluşma veya hediye sürprizi planlayın.', 'Plan a meeting or gift surprise with the final message.', true, 1, 100),
(gen_random_uuid(), '75215d40-923e-43f8-b2eb-1c3c74148d3a', 5, 'Mesaj Zincirini Başlatma', 'Start the Message Chain', 'İlk mesajı gönderin ve gün boyunca zinciri sürdürün.', 'Send the first message and continue the chain throughout the day.', true, 0, 0);

-- Scenario: "Open When..." Letter Set (open-when-letters)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '00fa5645-c203-4807-8f44-f79ef0150ece', 1, 'Mektup Konularını Belirleme', 'Determine Letter Topics', '''''Üzgün olduğunda aç'''', ''''Beni özlediğinde aç'''' gibi konuları belirleyin.', 'Determine topics like ''''Open when sad'''', ''''Open when you miss me''''.', false, 7, 0),
(gen_random_uuid(), '00fa5645-c203-4807-8f44-f79ef0150ece', 2, 'Kağıt ve Zarf Tedariki', 'Procure Paper and Envelopes', 'Renkli zarflar, güzel kağıtlar ve dekorasyon malzemeleri alın.', 'Get colorful envelopes, nice papers, and decoration materials.', false, 5, 100),
(gen_random_uuid(), '00fa5645-c203-4807-8f44-f79ef0150ece', 3, 'Mektupları Yazma', 'Write the Letters', 'Her konuya uygun duygusal ve destekleyici mektuplar yazın.', 'Write emotional and supportive letters appropriate for each topic.', false, 3, 0),
(gen_random_uuid(), '00fa5645-c203-4807-8f44-f79ef0150ece', 4, 'Zarfları Süsleme ve Etiketleme', 'Decorate and Label Envelopes', 'Her zarfı farklı renkte süsleyin ve konusunu yazın.', 'Decorate each envelope in a different color and write its topic.', true, 1, 0),
(gen_random_uuid(), '00fa5645-c203-4807-8f44-f79ef0150ece', 5, 'Mektup Setini Sunma', 'Present the Letter Set', 'Tüm mektupları bir kutuya koyun ve özürle birlikte sunun.', 'Put all letters in a box and present them with your apology.', true, 0, 30);

-- Scenario: Apology Photo Album (photo-album-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8da9dbc1-5b13-4dc9-816a-651edf9fc898', 1, 'Fotoğraf Seçimi', 'Select Photos', 'Birlikte olduğunuz en güzel anların fotoğraflarını seçin.', 'Select photos of the most beautiful moments you shared.', false, 7, 0),
(gen_random_uuid(), '8da9dbc1-5b13-4dc9-816a-651edf9fc898', 2, 'Albüm ve Baskı Siparişi', 'Order Album and Prints', 'Kaliteli bir fotoğraf albümü ve fotoğraf baskıları sipariş edin.', 'Order a quality photo album and photo prints.', false, 5, 300),
(gen_random_uuid(), '8da9dbc1-5b13-4dc9-816a-651edf9fc898', 3, 'Albümü Düzenleme', 'Arrange the Album', 'Fotoğrafları kronolojik sırayla albüme yerleştirin.', 'Place photos in the album in chronological order.', false, 3, 0),
(gen_random_uuid(), '8da9dbc1-5b13-4dc9-816a-651edf9fc898', 4, 'El Yazısı Notlar Ekleme', 'Add Handwritten Notes', 'Her fotoğrafın yanına anıyı anlatan kişisel notlar yazın.', 'Write personal notes describing the memory next to each photo.', true, 1, 0),
(gen_random_uuid(), '8da9dbc1-5b13-4dc9-816a-651edf9fc898', 5, 'Albümü Hediye Etme', 'Gift the Album', 'Fotoğraf albümünü samimi bir özürle birlikte sunun.', 'Present the photo album with a sincere apology.', true, 0, 0);

-- Scenario: Picnic Apology Surprise (picnic-apology-surprise)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c8430b10-9b67-4165-9e53-b8b5fe0ba5c5', 1, 'Piknik Mekanı Seçimi', 'Choose Picnic Spot', 'Sakin ve güzel bir piknik mekanı belirleyin.', 'Find a calm and beautiful picnic spot.', false, 5, 0),
(gen_random_uuid(), 'c8430b10-9b67-4165-9e53-b8b5fe0ba5c5', 2, 'Yiyecek ve İçecek Hazırlığı', 'Prepare Food and Drinks', 'Kişinin sevdiği yiyeceklerle piknik sepetini hazırlayın.', 'Prepare the picnic basket with the person''''s favorite foods.', false, 2, 300),
(gen_random_uuid(), 'c8430b10-9b67-4165-9e53-b8b5fe0ba5c5', 3, 'Piknik Ekipmanı ve Dekorasyon', 'Picnic Equipment and Decoration', 'Battaniye, tabak, mumlar ve çiçeklerle piknik alanını hazırlayın.', 'Prepare the picnic area with blankets, plates, candles, and flowers.', false, 1, 100),
(gen_random_uuid(), 'c8430b10-9b67-4165-9e53-b8b5fe0ba5c5', 4, 'Özür Kartı veya Mektup', 'Apology Card or Letter', 'Piknik sepetine samimi bir özür kartı veya mektup ekleyin.', 'Add a sincere apology card or letter to the picnic basket.', true, 1, 20),
(gen_random_uuid(), 'c8430b10-9b67-4165-9e53-b8b5fe0ba5c5', 5, 'Piknik Sürprizi', 'Picnic Surprise', 'Kişiyi piknik alanına götürün ve özür pikniğinin tadını çıkarın.', 'Take the person to the picnic area and enjoy the apology picnic.', true, 0, 0);

-- Scenario: Apology Playlist Gift (playlist-apology-gift)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '057b2a7a-3950-484a-9f3d-59789af81005', 1, 'Şarkı Listesi Araştırması', 'Research Song List', 'İlişkinize özel anlamlı şarkıları araştırın ve listeleyin.', 'Research and list meaningful songs special to your relationship.', false, 5, 0),
(gen_random_uuid(), '057b2a7a-3950-484a-9f3d-59789af81005', 2, 'Playlist Oluşturma', 'Create Playlist', 'Şarkıları anlamlı bir sırayla bir çalma listesine ekleyin.', 'Add songs to a playlist in a meaningful order.', false, 3, 0),
(gen_random_uuid(), '057b2a7a-3950-484a-9f3d-59789af81005', 3, 'Playlist Kapak Tasarımı', 'Design Playlist Cover', 'Playlistin kapak görselini kişiselleştirilmiş olarak tasarlayın.', 'Design a personalized cover image for the playlist.', false, 1, 0),
(gen_random_uuid(), '057b2a7a-3950-484a-9f3d-59789af81005', 4, 'Şarkı Açıklamaları Yazma', 'Write Song Descriptions', 'Her şarkının neden seçildiğini anlatan kısa notlar yazın.', 'Write short notes explaining why each song was chosen.', true, 1, 0),
(gen_random_uuid(), '057b2a7a-3950-484a-9f3d-59789af81005', 5, 'Playlisti Paylaşma', 'Share the Playlist', 'Playlisti özel bir mesajla birlikte paylaşın.', 'Share the playlist with a special message.', true, 0, 0);

-- Scenario: Podcast Apology Episode (podcast-apology-episode)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7257595b-0b99-4f8a-8485-adc9ca933cd4', 1, 'Bölüm İçeriği Planlama', 'Plan Episode Content', 'Özür bölümünün konularını ve akışını planlayın.', 'Plan the topics and flow of the apology episode.', false, 7, 0),
(gen_random_uuid(), '7257595b-0b99-4f8a-8485-adc9ca933cd4', 2, 'Kayıt Ekipmanı Hazırlama', 'Prepare Recording Equipment', 'Mikrofon ve kayıt yazılımını hazırlayın ve test edin.', 'Set up and test the microphone and recording software.', false, 3, 100),
(gen_random_uuid(), '7257595b-0b99-4f8a-8485-adc9ca933cd4', 3, 'Bölümü Kaydetme', 'Record the Episode', 'Samimi bir şekilde duygularınızı ve özrünüzü kaydedin.', 'Sincerely record your feelings and apology.', false, 1, 0),
(gen_random_uuid(), '7257595b-0b99-4f8a-8485-adc9ca933cd4', 4, 'Düzenleme ve Müzik', 'Edit and Add Music', 'Kaydı düzenleyin ve uygun arka plan müziği ekleyin.', 'Edit the recording and add appropriate background music.', true, 1, 0),
(gen_random_uuid(), '7257595b-0b99-4f8a-8485-adc9ca933cd4', 5, 'Bölümü Paylaşma', 'Share the Episode', 'Podcast bölümünü özel bir linkle kişiye gönderin.', 'Send the podcast episode to the person with a special link.', true, 0, 0);

-- Scenario: Room Transformation Apology (room-transformation-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '35b1fec7-6aa1-48c1-a152-a45becf65d1a', 1, 'Dönüşüm Konsepti Belirleme', 'Determine Transformation Concept', 'Odanın nasıl dönüştürüleceğini ve temasını planlayın.', 'Plan how the room will be transformed and its theme.', false, 5, 0),
(gen_random_uuid(), '35b1fec7-6aa1-48c1-a152-a45becf65d1a', 2, 'Dekorasyon Malzemeleri Satın Alma', 'Purchase Decoration Materials', 'Işık zincirleri, çiçekler, fotoğraflar ve süsleme malzemeleri alın.', 'Buy string lights, flowers, photos, and decoration materials.', false, 3, 500),
(gen_random_uuid(), '35b1fec7-6aa1-48c1-a152-a45becf65d1a', 3, 'Odayı Hazırlama', 'Prepare the Room', 'Kişi yokken odayı tamamen dönüştürün ve süsleyin.', 'Completely transform and decorate the room while the person is away.', false, 0, 0),
(gen_random_uuid(), '35b1fec7-6aa1-48c1-a152-a45becf65d1a', 4, 'Kişisel Dokunuşlar Ekleme', 'Add Personal Touches', 'Özür mektubu, fotoğraflar ve anlamlı objeler yerleştirin.', 'Place an apology letter, photos, and meaningful objects.', true, 0, 0),
(gen_random_uuid(), '35b1fec7-6aa1-48c1-a152-a45becf65d1a', 5, 'Sürpriz Anı', 'Surprise Moment', 'Kişiyi dönüştürülmüş odaya davet edin ve tepkisini izleyin.', 'Invite the person to the transformed room and watch their reaction.', true, 0, 0);

-- Scenario: Scrapbook Apology (scrapbook-apology)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'abb565c1-a47b-4d6f-99a4-e175a4cc41aa', 1, 'Karalama Defteri Malzemeleri', 'Scrapbook Supplies', 'Boş defter, fotoğraflar, sticker ve süsleme malzemeleri satın alın.', 'Purchase a blank notebook, photos, stickers, and decoration supplies.', false, 7, 150),
(gen_random_uuid(), 'abb565c1-a47b-4d6f-99a4-e175a4cc41aa', 2, 'Sayfa Konularını Belirleme', 'Determine Page Topics', 'Her sayfa için bir konu belirleyin: ilk anılar, komik anlar, özür vb.', 'Determine a topic for each page: first memories, funny moments, apology, etc.', false, 5, 0),
(gen_random_uuid(), 'abb565c1-a47b-4d6f-99a4-e175a4cc41aa', 3, 'Sayfaları Tasarlama ve Oluşturma', 'Design and Create Pages', 'Fotoğrafları yapıştırın, süsleyin ve sayfaları tamamlayın.', 'Paste photos, decorate, and complete the pages.', false, 3, 0),
(gen_random_uuid(), 'abb565c1-a47b-4d6f-99a4-e175a4cc41aa', 4, 'Özür Sayfası Ekleme', 'Add Apology Page', 'Son sayfaya samimi bir özür mesajı ve gelecek vaatleri yazın.', 'Write a sincere apology message and future promises on the last page.', true, 1, 0),
(gen_random_uuid(), 'abb565c1-a47b-4d6f-99a4-e175a4cc41aa', 5, 'Defteri Hediye Etme', 'Gift the Scrapbook', 'Karalama defterini duygusal bir anla hediye edin.', 'Gift the scrapbook at an emotional moment.', true, 0, 0);
