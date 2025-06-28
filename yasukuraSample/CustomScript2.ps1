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

# [代替案#1] C:\Windows\Setup\Scripts\SetupComplete.cmdでタイムゾーンを変更する -> 失敗
$scriptPath = "C:\Windows\Setup\Scripts\SetupComplete.cmd"
$timezoneCommand = 'powershell.exe -ExecutionPolicy Bypass -Command "Set-TimeZone -Id ''Tokyo Standard Time''"'
# フォルダが存在しない場合は作成
$folderPath = Split-Path $scriptPath
if (!(Test-Path $folderPath)) {
   New-Item -Path $folderPath -ItemType Directory -Force
}
# ファイルが存在しない場合は初期化
if (!(Test-Path $scriptPath)) {
   Set-Content -Path $scriptPath -Value "@echo off" -Encoding ASCII
}
# タイムゾーン設定が未記載なら追記
if (-not (Get-Content $scriptPath | Select-String "Set-TimeZone")) {
   Add-Content -Path $scriptPath -Value "`r`n" + $timezoneCommand -Encoding ASCII
}

# [代替案#2]　C:\Windows\Panther\Unattend\Unattend.xml で sysprep時にタイムゾーンを変更する
#$unattendContent = @"
#<?xml version="1.0" encoding="utf-8"?>
#<unattend xmlns="urn:schemas-microsoft-com:unattend">
#  <settings pass="oobeSystem">
#    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64"
#               publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
#      <TimeZone>Tokyo Standard Time</TimeZone>
#      <FirstLogonCommands>
#        <SynchronousCommand wcm:action="add">
#          <Order>1</Order>
#          <Description>Set TimeZone</Description>
#          <CommandLine>powershell.exe -ExecutionPolicy Bypass -Command "Set-TimeZone -Id 'Tokyo Standard Time'"</CommandLine>
#        </SynchronousCommand>
#      </FirstLogonCommands>
#    </component>
#  </settings>
#</unattend>
#"@
#$unattendPath = "C:\Windows\Panther\Unattend\Unattend.xml"
#New-Item -ItemType Directory -Path (Split-Path $unattendPath) -Force
#$unattendContent | Out-File -FilePath $unattendPath -Encoding utf8
