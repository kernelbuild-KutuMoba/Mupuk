#!/bin/bash


token="5445531176:AAGwd6pVM-UoDrNos3R00QSlr0KuffkZLMY"
chat_id="-1001921678002"

#
TANGGAL_MULAI="2026-08-01" 

detik_mulai=$(date -d "$TANGGAL_MULAI" +%s)
detik_target=$((detik_mulai + 5184000)) # 60 hari dalam detik

detik_sekarang=$(date +%s)

hari_berlalu=$(( (detik_sekarang - detik_mulai) / 86400 ))
hari_ke=$(( hari_berlalu + 1 ))
sisa_hari=$(( 60 - hari_ke ))
hari_ini=$(date +%d-%m-%y)

function_sendinfo() {
    local pesan="$1"
    curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
        -d chat_id="$chat_id" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="$pesan" 
}

if [ "$detik_sekarang" -ge "$detik_target" ]; then
    echo "STATUS=BERHASIL"
    
    PESAN_TELEGRAM="🚨 PEMBERITAHUAN UTAMA: %0A Waktu 60 hari telah terpenuhi hari ini! %0A Skrip selesai. %0A Sekarang tanggal $hari_ini"
    function_sendinfo "$PESAN_TELEGRAM"
    
    exit 0
else
    echo "STATUS=PENDING"
    
    hari_ke=$(( hari_berlalu + 1 ))
    
    PESAN_TELEGRAM="🕒 Pengingat Harian Pemupukan: %0A Hari ke-$hari_ke sedang berjalan. %0A Sisa waktu: $sisa_hari hari lagi. %0A sekarang tanggal $hari_ini"
    function_sendinfo "$PESAN_TELEGRAM"
    
    exit 0
fi
