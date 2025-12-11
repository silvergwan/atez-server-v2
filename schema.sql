-- ============================
-- USER TABLE
-- ============================
CREATE TABLE "User" (
    user_id         BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255),
    nickname        VARCHAR(50),
    hashed_password VARCHAR(255),
    user_created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================
-- CHARACTER TABLE
-- ============================
CREATE TABLE "Character" (
    char_id            BIGSERIAL PRIMARY KEY,
    name               VARCHAR(50),
    personality        TEXT,
    speaking_style     TEXT,
    background         TEXT,
    example_dialogues  JSONB,
    char_created_at    TIMESTAMPTZ DEFAULT NOW(),
    user_id            BIGINT NOT NULL
);

ALTER TABLE "Character"
ADD CONSTRAINT FK_character_user
FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;


-- ============================
-- SESSIONS TABLE
-- ============================
CREATE TABLE "Sessions" (
    session_id        BIGSERIAL PRIMARY KEY,
    session_created_at TIMESTAMPTZ DEFAULT NOW(),
    user_id           BIGINT NOT NULL,
    char_id           BIGINT NOT NULL
);

ALTER TABLE "Sessions"
ADD CONSTRAINT FK_sessions_user
FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;

ALTER TABLE "Sessions"
ADD CONSTRAINT FK_sessions_char
FOREIGN KEY (char_id) REFERENCES "Character"(char_id) ON DELETE CASCADE;


-- ============================
-- MESSAGES TABLE
-- ============================
CREATE TABLE "Messages" (
    message_id        BIGSERIAL PRIMARY KEY,
    role              VARCHAR(20),
    content           TEXT,
    message_created_at TIMESTAMPTZ DEFAULT NOW(),
    session_id        BIGINT NOT NULL,
    experiment_key    VARCHAR(100)
);

ALTER TABLE "Messages"
ADD CONSTRAINT FK_messages_session
FOREIGN KEY (session_id) REFERENCES "Sessions"(session_id) ON DELETE CASCADE;


-- ============================
-- EXPERIMENT ASSIGNMENTS TABLE
-- ============================
CREATE TABLE experiment_assignments (
    experiment_key VARCHAR(100) NOT NULL,
    user_id        BIGINT NOT NULL,
    "group"        VARCHAR(20),
    PRIMARY KEY (experiment_key, user_id)
);

ALTER TABLE experiment_assignments
ADD CONSTRAINT FK_experiment_user
FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;
