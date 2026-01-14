#!/bin/bash

# ==========================================
# Git Bash "ZSH-Like" 環境安裝/更新工具 V2
# 適用: Windows Git Bash (Non-Admin, No Exe)
# 功能: 智能判斷安裝或更新 Ble.sh 與 Oh My Bash
# ==========================================

echo ">>> 啟動安裝/更新程序 (V2)..."

# 1. 定義路徑
BLE_DIR="$HOME/ble-nightly"
OMB_DIR="$HOME/.oh-my-bash"
BASHRC="$HOME/.bashrc"
BLERC="$HOME/.blerc"
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)

# 2. 備份設定檔 (安全網)
if [ -f "$BASHRC" ]; then
    echo ">>> [備份] 現有設定檔已備份至 .bashrc.bak.$BACKUP_DATE"
    cp "$BASHRC" "$BASHRC.bak.$BACKUP_DATE"
fi

# 3. 處理 Ble.sh (暴力更新法：刪除重載)
# 因為它是 binary/script 包，直接重抓最快最穩
echo ">>> [Ble.sh] 正在處理..."
if [ -d "$BLE_DIR" ]; then
    echo "    偵測到舊版本，正在移除以進行升級..."
    rm -rf "$BLE_DIR"
fi
echo "    下載並解壓最新 Nightly 版本..."
mkdir -p "$BLE_DIR"
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - --strip-components=1 -C "$BLE_DIR"

# 4. 處理 Oh My Bash (Git 更新法)
# 如果已存在則 pull，不存在則 clone
echo ">>> [Oh My Bash] 正在處理..."
if [ -d "$OMB_DIR" ]; then
    echo "    偵測到已安裝，正在執行 Git Pull 更新..."
    # 這裡使用子殼層 (subshell) 進入目錄更新，不影響主程序路徑
    (cd "$OMB_DIR" && git pull)
else
    echo "    初次安裝，正在 Clone 倉庫..."
    git clone https://github.com/ohmybash/oh-my-bash.git "$OMB_DIR"
fi

# 5. 設定 Tab 鍵行為
echo ">>> [設定] 更新 Tab 鍵補全邏輯..."
cat > "$BLERC" << 'EOF'
ble-bind -m auto_complete -f TAB auto_complete/insert
ble-bind -m auto_complete -f C-i auto_complete/insert
EOF

# 6. 重寫 .bashrc (確保路徑與設定正確)
# 注意：這會重置您的主要設定檔。如果您有客製化 Alias，請從備份檔找回。
echo ">>> [設定] 重寫 .bashrc..."

cat > "$BASHRC" << EOF
# [1] 語系設定 (防止亂碼)
export LANG=en_US.UTF-8

# [2] 啟動 Ble.sh (必須在最上方)
source $BLE_DIR/ble.sh

# [3] 載入 Tab 鍵習慣設定
[ -f ~/.blerc ] && source ~/.blerc

# [4] Oh My Bash 設定
export OSH="$OMB_DIR"
OSH_THEME="font"  # 可改用 'agnoster' 或 'bobby'
completions=(git composer ssh gem npm)
aliases=(general)
plugins=(git bashmarks)
source "\$OSH/oh-my-bash.sh"

# [5] 使用者自訂 Alias (範例)
# alias gs='git status'
EOF

# 7. 確保 Profile 連結
if ! grep -q ".bashrc" "$HOME/.bash_profile" 2>/dev/null; then
    echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" >> "$HOME/.bash_profile"
fi

echo "=========================================="
echo ">>> 全部完成！"
echo ">>> 若為更新：新功能已就緒，設定檔已重置 (舊檔已備份)。"
echo ">>> 請執行 'source ~/.bashrc' 或重啟視窗。"
echo "=========================================="