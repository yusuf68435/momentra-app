-- Seed categories
INSERT INTO public.categories (slug, name_tr, name_en, description_tr, description_en, icon, color, sort_order) VALUES
('proposal', 'Evlilik Teklifi', 'Marriage Proposal', 'Hayatinizin en ozel anini planlayin', 'Plan the most special moment of your life', 'ring', '#E91E63', 1),
('birthday', 'Dogum Gunu', 'Birthday', 'Unutulmaz dogum gunu surprizleri', 'Unforgettable birthday surprises', 'cake-variant', '#FF9800', 2),
('anniversary', 'Yildonumu', 'Anniversary', 'Ozel gunlerinizi kutlayin', 'Celebrate your special days', 'heart', '#F44336', 3),
('graduation', 'Mezuniyet', 'Graduation', 'Basariyi kutlamanin en guzel yollari', 'The best ways to celebrate success', 'school', '#9C27B0', 4),
('baby', 'Bebek / Cinsiyet', 'Baby / Gender Reveal', 'Yeni hayatin heyecanini paylasin', 'Share the excitement of new life', 'baby-carriage', '#4CAF50', 5),
('romantic', 'Romantik Surpriz', 'Romantic Surprise', 'Ask dolu anlar yaratın', 'Create moments full of love', 'flower', '#E91E63', 6),
('friendship', 'Arkadaslik', 'Friendship', 'Arkadasliginizi kutlayin', 'Celebrate your friendship', 'account-group', '#2196F3', 7),
('apology', 'Ozur / Barisma', 'Apology / Making Up', 'Kalpleri onarmanin yollari', 'Ways to mend hearts', 'hand-heart', '#607D8B', 8),
('achievement', 'Kutlama / Basari', 'Celebration / Achievement', 'Her basariyi ozel kilin', 'Make every achievement special', 'trophy', '#FFC107', 9),
('holiday', 'Ozel Gun', 'Special Day', 'Ozel gunler icin ozel fikirler', 'Special ideas for special days', 'calendar-star', '#00BCD4', 10)
ON CONFLICT (slug) DO NOTHING;
