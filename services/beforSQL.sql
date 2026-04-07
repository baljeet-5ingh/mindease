-- =========================================
-- ENUMS
-- =========================================

CREATE TYPE emotion AS ENUM ('NEUTRAL', 'HAPPY', 'SAD', 'ANGRY', 'STRESSED');
CREATE TYPE message_role AS ENUM ('USER', 'BOT');
CREATE TYPE alert_severity AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- =========================================
-- USER TABLE
-- =========================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clerk_id VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    image_url TEXT,

    api_key_hash TEXT UNIQUE,
    emotion_key_hash TEXT UNIQUE
);

-- =========================================
-- DATA POINTS (TIME SERIES)
-- =========================================

CREATE TABLE data_points (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    heart_rate INT,
    spo2 FLOAT,
    emotion emotion,
    confidence FLOAT,
    source VARCHAR(50),
    device_id VARCHAR(100),
    correlation_id UUID,
    merged BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_data_user_time ON data_points(user_id, timestamp);

-- =========================================
-- CHAT SYSTEM
-- =========================================

CREATE TABLE chat_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,

    role message_role,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- EMERGENCY ALERTS
-- =========================================

CREATE TABLE emergency_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    severity alert_severity,
    message TEXT
);

-- =========================================
-- HELPLINE RESOURCES
-- =========================================

CREATE TABLE helpline_resources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    url TEXT
);

-- =========================================
-- RAW READINGS (JSON SUPPORT)
-- =========================================

CREATE TABLE raw_readings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payload JSONB,
    source VARCHAR(50),
    device_id VARCHAR(100),
    correlation_id UUID,
    processed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_raw_user_time ON raw_readings(user_id, created_at);

-- =========================================
-- USER SETTINGS (1:1)
-- =========================================

CREATE TABLE user_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,

    notifications_enabled BOOLEAN DEFAULT TRUE
);