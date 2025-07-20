-- DROP TABLE public.speaking_topics;

CREATE TABLE public.speaking_topics (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	title text NOT NULL,
	description text NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT speaking_topics_pkey PRIMARY KEY (id)
);

INSERT INTO public.speaking_topics (id,title,description,created_at) VALUES
	 ('d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'Daily Life','Everyday personal routines','2025-07-19 01:10:54.292278'),
	 ('d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'Hobbies','Leisure activities and habits','2025-07-19 01:12:00.919082'),
	 ('15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'Travel','Travel experiences and plans','2025-07-19 01:12:00.919082'),
	 ('7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'Food','Eating habits and preferences','2025-07-19 01:12:00.919082'),
	 ('2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'Education','School and learning topics','2025-07-19 01:12:00.919082'),
	 ('302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'Family','Family and relationships','2025-07-19 01:12:00.919082'),
	 ('5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'Technology','Gadgets and online behavior','2025-07-19 01:12:00.919082'),
	 ('410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'Work','Jobs and ambitions','2025-07-19 01:12:00.919082'),
	 ('973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'Opinions','Debatable thoughts or beliefs','2025-07-19 01:12:00.919082'),
	 ('2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'Self-reflection','Feelings and personal insights','2025-07-19 01:12:00.919082');


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	email varchar(255) NOT NULL,
	password_hash text NOT NULL,
	create_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	last_login timestamp NULL,
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id)
);


-- public.questions definition

-- Drop table

-- DROP TABLE public.questions;

CREATE TABLE public.questions (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	question_text text NOT NULL,
	language_code varchar(10) DEFAULT 'en-US'::character varying NULL,
	difficulty_level varchar(20) NULL,
	topic uuid NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT questions_difficulty_level_check CHECK (((difficulty_level)::text = ANY ((ARRAY['easy'::character varying, 'medium'::character varying, 'hard'::character varying])::text[]))),
	CONSTRAINT questions_pkey PRIMARY KEY (id),
	CONSTRAINT questions_topic_fkey FOREIGN KEY (topic) REFERENCES public.speaking_topics(id) ON DELETE CASCADE
);

INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('7fab155c-ee42-4b97-9128-3630086aae3f'::uuid,'What time do you usually wake up?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('bbf44107-7bdc-45a6-962a-9650e14afe61'::uuid,'What do you normally eat for breakfast?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('25f73d56-8042-48ee-ab39-8747a048e402'::uuid,'How do you get to work or school?','en-US','hard','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('1fc740f4-f8de-4cf4-8efa-68edc75109d9'::uuid,'What is your daily routine?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0040f166-4c1a-4a52-973a-4d8a8bec1001'::uuid,'Do you prefer mornings or evenings?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('496bfc4c-05e0-48fc-8e41-647388c9edae'::uuid,'What do you do after work?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('3c555bb2-867f-4537-81c8-1b170aac454a'::uuid,'How often do you exercise?','en-US','hard','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('fcc6811d-86da-4c43-9c3b-9d4b6c45c2f8'::uuid,'What chores do you usually do at home?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('e7743959-cc34-469c-961c-e548fbfb0269'::uuid,'What’s your favorite time of the day?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134'),
	 ('cbfce9bc-10e8-418d-8f6c-8105956c04cd'::uuid,'Do you take naps during the day?','en-US','medium','d454f839-d80e-47c1-8f66-d379d9375664'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('d0efd081-2857-49a9-b9bc-a68098176f75'::uuid,'What do you like to do in your free time?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('4d9acb05-42bc-4ed9-928e-12d36f5aca17'::uuid,'Do you play any musical instruments?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('665ac3fa-ec77-49df-b4a7-097549e88e4e'::uuid,'What kind of music do you like?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('5c7e57c2-4a98-4aa6-b50a-f905a476aee8'::uuid,'Do you enjoy reading books?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('b04daff4-db2e-4dbf-9333-eb90d6634c8e'::uuid,'What''s your favorite TV show or movie?','en-US','hard','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('2a041446-60d6-4ad5-a599-8d9f41013372'::uuid,'How often do you watch movies?','en-US','hard','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f5b64339-f9ef-4c4b-b163-da2948327eac'::uuid,'Do you prefer indoor or outdoor activities?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('983ba4fe-9477-4772-a60a-0a9e7b21be8e'::uuid,'What is your favorite hobby?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('8df2bb9c-c529-45be-bae0-cf817bac7de4'::uuid,'How do you relax after a busy day?','en-US','hard','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134'),
	 ('fc849958-ec75-445d-b9b0-2fb38270c1e7'::uuid,'Have you ever tried painting or drawing?','en-US','medium','d6556fc7-7f32-4fe4-9a46-755cb0883095'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('48c010da-8ec8-49e9-afed-9425956c2042'::uuid,'Have you ever traveled abroad?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('93756979-62b8-456c-af20-d994b27de3d5'::uuid,'What’s your dream travel destination?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('3be5f088-f9dc-481d-a203-60dc9a1891d4'::uuid,'Do you like traveling by plane?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('c41be0c1-3568-46e4-bfb0-b0ba9f98cbd0'::uuid,'What city would you love to visit again?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('2b0f57ad-d7b2-4b0c-8a3e-637b2d59720a'::uuid,'What’s your favorite place in your country?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('90282603-3799-42e3-8067-067c92bb6f1b'::uuid,'Do you prefer the beach or the mountains?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('607c0840-33c5-461d-ba93-561aeb126bea'::uuid,'What do you usually pack for a trip?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f7c6e604-bd67-4e93-ba3d-c4c43322492e'::uuid,'Do you travel often with your family?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0a190953-4a13-47e8-895c-e4b0aa8afd5b'::uuid,'What do you usually do when you travel?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134'),
	 ('825e8222-e9a8-497d-aef1-c3ccfdd8c80b'::uuid,'What’s the best trip you’ve ever had?','en-US','medium','15882d47-bb53-4717-b2c0-a063ec5b7f6c'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('81d8d4f5-0915-4713-a0c2-e722277fadef'::uuid,'What is your favorite food?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ae53c5f3-ea92-49cc-b275-920787d9488a'::uuid,'Can you cook? If yes, what dishes?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ab402e3d-6537-437a-8471-74310b5eb21a'::uuid,'Do you prefer home-cooked meals or eating out?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('3ab362bd-1018-4dcd-9870-ab09691ce37c'::uuid,'What’s your favorite restaurant?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ab7240d3-8827-4bae-a849-50285947f65e'::uuid,'How often do you eat fast food?','en-US','hard','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('7f48242f-f62a-4929-bae9-c9d1655d2d51'::uuid,'What kind of food do you dislike?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('b7ffff74-dd4d-4da0-bd27-b483d43a780d'::uuid,'What do you usually eat for lunch?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('daf647b0-e446-4f8d-9c10-1f1769809fbe'::uuid,'Do you like trying new cuisines?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ecdab0ab-7bc9-43df-b805-bf730a03cb20'::uuid,'What do you drink in the morning?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f8726a2d-76e4-4cdd-b5ba-c4e0da80865c'::uuid,'Do you like spicy food?','en-US','medium','7766701c-fb66-436c-976e-4ca9f954aa34'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('4b74680b-4444-4e4d-81f5-26bd55f28611'::uuid,'What subjects did you like in school?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('46a16372-2621-47d0-a9bb-1a5f51bd42a1'::uuid,'Do you enjoy learning new things?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('965dd199-029d-4e42-9f90-ae581553b1b5'::uuid,'What language would you like to learn?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ca8c25ae-8f9f-48e7-b976-08ab943217ab'::uuid,'Who was your favorite teacher?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('65961719-b470-4172-b0a0-13e73c6588cb'::uuid,'Do you think online learning is effective?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('afaeac7f-0eaa-476b-afee-ea1c25bad628'::uuid,'What was your best memory at school?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('40f98683-7328-4e31-a51b-90fef6d78350'::uuid,'What subject was the most difficult for you?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('e3b37491-ac5f-4739-b6d6-179800a768b8'::uuid,'Do you prefer studying alone or in groups?','en-US','medium','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('2adc37fd-38a3-4845-99f4-4845cef9361c'::uuid,'What skills are important to learn nowadays?','en-US','hard','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f4cf55c0-b4de-47cd-b11a-5ade637fb0a1'::uuid,'Did you enjoy your school life?','en-US','easy','2a8af792-47c9-41b9-9e9b-db983b759476'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('1eddfb28-b390-49f3-a13e-56681bec76c1'::uuid,'How many people are there in your family?','en-US','hard','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('350e2622-3f25-4569-8329-8deacbcd9e74'::uuid,'Who are you closest to in your family?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('bde61983-15ba-4a0c-aa5b-0a5d9b2c1190'::uuid,'Do you have any siblings?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0b5a3c7e-471f-49a4-a975-640dbe433704'::uuid,'How do you usually spend time with your family?','en-US','hard','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('73cac8b6-bb38-41fb-a9a2-88ce8a9a057b'::uuid,'What do you do when you meet your friends?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('9811eeb4-945d-4d8d-815c-16d0bc7f24a3'::uuid,'Do you often keep in touch with old friends?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('6b4a0c36-9160-4686-b9ba-1d8bd5edf565'::uuid,'What qualities do you look for in a friend?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('c5fa44f7-0a18-481a-8924-a79e4f08f77a'::uuid,'What’s the best memory you have with your family?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('e35d5042-3f8e-47d5-82a4-910d1436b22b'::uuid,'Who gives you advice when you''re in trouble?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134'),
	 ('1c98bb8c-4472-4f97-b402-1f61c4159938'::uuid,'Do you live with your family?','en-US','medium','302d38e4-07ae-4324-a377-3566a01d5b43'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('b108a59d-2d2f-4282-9a2c-408a65c39a16'::uuid,'How often do you use your smartphone?','en-US','hard','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('01f08372-897b-45a7-b80c-ab818e45f34f'::uuid,'What apps do you use the most?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('5953cbe4-0d5c-4f61-9356-65278ba136bd'::uuid,'Do you prefer texting or calling?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('00e4ad8b-2f96-4a17-9ffe-10d6fb7de397'::uuid,'How do you feel about social media?','en-US','hard','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('98ad7d82-860d-4c5c-9794-a2f5c2391ce0'::uuid,'Do you spend too much time online?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('34e64182-2ecd-4ba1-8756-ecebd960f696'::uuid,'What’s your favorite website?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('fb0dd1a3-0b13-4a6b-a720-d8734ebbc58d'::uuid,'How do you stay updated with news?','en-US','hard','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('d8544d2b-f246-40fd-80ae-eaf4243c0111'::uuid,'Do you use technology to study or work?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('a276b86c-75b5-42f4-bf2f-381a234dc638'::uuid,'What’s one gadget you can’t live without?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134'),
	 ('c6ae882a-a123-4551-850c-6a947be40e8c'::uuid,'Do you shop online?','en-US','medium','5492479b-e895-48af-90e8-929e6fcbd757'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('f6d4b4e8-1e81-44c4-9a42-9fba7f5a5ca7'::uuid,'What do you do for a living?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('80eab694-1435-422f-ba08-b62afca74206'::uuid,'What’s your dream job?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ebb6905b-8eb7-475c-9819-da12843eef05'::uuid,'Do you prefer working in an office or remotely?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('c4397e28-9eba-4e35-8d15-585716a1ee69'::uuid,'What skills are important for your job?','en-US','hard','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('cf997137-72ec-4623-8ee5-4f165279d1bf'::uuid,'What motivates you at work?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('8ef52742-4c27-4a05-acb1-2a734c8b12b5'::uuid,'Do you enjoy your current job?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('a800d27b-9340-40ba-9045-ef457fd64c72'::uuid,'How do you manage stress at work?','en-US','hard','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0cc810c1-0adb-414c-81dc-67d3edcd0b52'::uuid,'What’s a goal you’re working on right now?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('6a0ed284-82e9-4880-8f46-dee48f734f5d'::uuid,'What do you want to achieve in 5 years?','en-US','medium','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0fa5fda0-9ef2-4c7c-b7fc-82bb01ca98b9'::uuid,'How do you stay productive?','en-US','hard','410b8cae-14f3-45c1-9cea-c99c03c855f2'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('620c5884-0127-4175-ad3a-a1b674303ebe'::uuid,'What makes a good leader?','en-US','medium','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('addabcc2-fb07-4483-86e2-63b31128267a'::uuid,'What do you think about climate change?','en-US','hard','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('d02462bf-71d6-44c4-8b60-2d7daf40b697'::uuid,'Should students wear school uniforms?','en-US','easy','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('2d920159-414b-4a94-b302-66971d0cbbbc'::uuid,'Is money the most important thing in life?','en-US','hard','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('0e3d6e4c-53ba-475a-b3f4-27e551fc358a'::uuid,'Do you think technology brings people closer?','en-US','medium','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ed8f0bd1-010a-4168-8646-2da0c786dc88'::uuid,'What is success to you?','en-US','hard','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('2398edaa-0fe0-43e9-b6b1-f3d8f6b09665'::uuid,'What are the advantages of learning English?','en-US','medium','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('9283074e-bb74-416f-9df4-5d0461699c41'::uuid,'Do you think AI will take over jobs?','en-US','medium','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('83ef02e6-3edb-4480-b299-f44c1f01e361'::uuid,'Should people work less and live more?','en-US','easy','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134'),
	 ('1664fc81-700e-4239-b856-4d1dd5c9308d'::uuid,'How can we protect the environment?','en-US','hard','973d0d3e-c4c0-410f-b700-549a57c411e0'::uuid,'2025-07-19 01:23:44.426134');
INSERT INTO public.questions (id,question_text,language_code,difficulty_level,topic,created_at) VALUES
	 ('9cf8a90c-61ea-49d7-8d74-840249233d78'::uuid,'What makes you happy?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('372d7b7a-abfd-48bc-9b84-c518b3a303bc'::uuid,'What do you fear the most?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f0539dde-f600-47d2-9ca4-1f6f66c5b83e'::uuid,'How do you deal with negative emotions?','en-US','hard','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('ca92a8d3-5d35-4a76-bb10-c38d3523ffa6'::uuid,'What are your strengths and weaknesses?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('1af8cba0-12b8-400a-a89a-3e5ccd3cf806'::uuid,'What do you do when you feel bored?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('f8a557a5-f644-4da6-b07f-c73f13fbeda4'::uuid,'What’s something you’re proud of?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('48d77c91-ad5d-4acb-956e-a23429df4b89'::uuid,'How do you stay motivated?','en-US','hard','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('8d61f1cd-7b6d-4da7-aeee-6f5f4d6d353d'::uuid,'What’s the most important lesson you’ve learned?','en-US','hard','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('1efa7aa2-cf44-4e5f-baf7-024edce0f01a'::uuid,'When was the last time you cried and why?','en-US','hard','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134'),
	 ('161f5e60-3cff-4ea2-aeca-218aa3c7fe40'::uuid,'What does “a good life” mean to you?','en-US','medium','2135d75f-e3a8-4493-a996-e0091b4a32fe'::uuid,'2025-07-19 01:23:44.426134');


-- public.user_answers definition

-- Drop table

-- DROP TABLE public.user_answers;

CREATE TABLE public.user_answers (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	user_id uuid NULL,
	question_id uuid NULL,
	audio_file_path text NULL,
	transcription text NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT user_answers_pkey PRIMARY KEY (id),
	CONSTRAINT user_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id),
	CONSTRAINT user_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);


-- public.audio_assessments definition

-- Drop table

-- DROP TABLE public.audio_assessments;

CREATE TABLE public.audio_assessments (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	user_answer_id uuid NULL,
	original_text text NOT NULL,
	pronunciation_score int4 NULL,
	accuracy_score int4 NULL,
	fluency_score int4 NULL,
	completeness_score int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	gemini_feedback text NULL,
	CONSTRAINT audio_assessments_pkey PRIMARY KEY (id),
	CONSTRAINT audio_assessments_user_answer_id_fkey FOREIGN KEY (user_answer_id) REFERENCES public.user_answers(id)
);


-- public.audio_words definition

-- Drop table

-- DROP TABLE public.audio_words;

CREATE TABLE public.audio_words (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	assessment_id uuid NULL,
	word text NOT NULL,
	accuracy_score int4 NULL,
	error_type text NULL,
	CONSTRAINT audio_words_pkey PRIMARY KEY (id),
	CONSTRAINT audio_words_assessment_id_fkey FOREIGN KEY (assessment_id) REFERENCES public.audio_assessments(id) ON DELETE CASCADE
);


-- public.audio_phonemes definition

-- Drop table

-- DROP TABLE public.audio_phonemes;

CREATE TABLE public.audio_phonemes (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	word_id uuid NULL,
	phoneme text NOT NULL,
	accuracy_score int4 NULL,
	error_type text NULL,
	CONSTRAINT audio_phonemes_pkey PRIMARY KEY (id),
	CONSTRAINT audio_phonemes_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.audio_words(id) ON DELETE CASCADE
);


-- public.audio_syllables definition

-- Drop table

-- DROP TABLE public.audio_syllables;

CREATE TABLE public.audio_syllables (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	word_id uuid NULL,
	syllable text NOT NULL,
	accuracy_score int4 NULL,
	CONSTRAINT audio_syllables_pkey PRIMARY KEY (id),
	CONSTRAINT audio_syllables_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.audio_words(id) ON DELETE CASCADE
);