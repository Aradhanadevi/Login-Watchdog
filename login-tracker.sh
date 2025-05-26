#!/bin/bash

# === Paths ===
PROJECT_DIR="$HOME/Desktop/Projects/Login_Watchdog"
LOG_DIR="$PROJECT_DIR/logs"
SUMMARY_LOG="$LOG_DIR/main_log.log"
LAST_CHECK_FILE="$LOG_DIR/last_check.txt"

# === Prepare folders ===
mkdir -p "$LOG_DIR"

# === Init timestamp file if first run ===
if [ ! -f "$LAST_CHECK_FILE" ]; then
    date "+%Y-%m-%d %H:%M:%S" > "$LAST_CHECK_FILE"
fi

LAST_CHECK=$(cat "$LAST_CHECK_FILE")
NOW=$(date "+%Y-%m-%d_%H-%M-%S")
RUN_LOG="$LOG_DIR/log_$NOW.log"

# === Log check start ===
echo "[$(date)] Checking for new logins since $LAST_CHECK..." | tee -a "$SUMMARY_LOG" >> "$RUN_LOG"

# === Check for new session logins ===
NEW_LOGINS=$(awk -v last="$LAST_CHECK" '$0 > last' /var/log/auth.log | grep "session opened for user")

if [ -n "$NEW_LOGINS" ]; then
    echo "$NEW_LOGINS" | tee -a "$SUMMARY_LOG" >> "$RUN_LOG"
    notify-send "Login Alert" "New login detected"
    echo "[$(date)] New login detected!" | tee -a "$SUMMARY_LOG" >> "$RUN_LOG"
else
    echo "[$(date)] No new logins." | tee -a "$SUMMARY_LOG" >> "$RUN_LOG"
fi

# === Update last check time ===
date "+%Y-%m-%d %H:%M:%S" > "$LAST_CHECK_FILE"

