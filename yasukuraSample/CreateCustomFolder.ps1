### カスタムフォルダ作成 
# Azure Virtual Desktop カスタムイメージ用スクリプト: デフォルトユーザーのデスクトップにフォルダを作成
# フォルダ名は必要に応じて変更してください
$folderName = "CustomFolder01"                              # 作成するフォルダ名
$defaultDesktop = "C:\Users\Default\Desktop"
$targetPath   = Join-Path -Path $defaultDesktop -ChildPath $folderName

# フォルダが存在しない場合に新規作成
if (!(Test-Path -Path $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    Write-Host "Folder '$folderName' created in Default user Desktop ($targetPath)."
} else {
    Write-Host "Folder '$folderName' already exists at $targetPath."
}

#### システム設定
# 時刻・日付などの表示形式が言語リストに追従するよう設定
Set-WinCultureFromLanguageListOptOut -OptOut $False

# デフォルトの入力方法を日本語IMEに変更
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

# システムロケールを日本 (ja-JP) に設定
Set-WinSystemLocale -SystemLocale ja-JP

# ようこそ画面と新規ユーザーアカウントにも現在の国際設定をコピー
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

# タイムゾーンを日本標準時(東京)に設定 -> Sysprepでリセットされている可能性が高い
# Set-TimeZone -Id "Tokyo Standard Time"
# [代替案]　C:\Windows\Setup\Scripts\SetupComplete.cmdでタイムゾーンを変更する

$scriptPath = "C:\Windows\Setup\Scripts\SetupComplete.cmd"

# フォルダが存在しない場合は作成
$folderPath = Split-Path $scriptPath
if (!(Test-Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory -Force
}

# ファイルが存在するか確認し、内容を追記
$timezoneCommand = 'powershell.exe -ExecutionPolicy Bypass -Command "Set-TimeZone -Id ''Tokyo Standard Time''"'

if (!(Test-Path $scriptPath)) {
    Add-Content -Path $scriptPath -Value "@echo off"
}
Add-Content -Path $scriptPath -Value $timezoneCommand
