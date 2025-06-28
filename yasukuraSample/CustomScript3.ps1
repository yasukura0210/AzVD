### カスタムフォルダ作成 

# Azure Virtual Desktop カスタムイメージ用スクリプト: デフォルトユーザーのデスクトップにフォルダを作成
$folderName1 = "CustomFolder01"
$folderName2 = "CustomFolder02"
$defaultDesktop1 = "C:\Users\Default\Desktop"
$defaultDesktop2 = "C:\Users\Public\Desktop "
$targetPath1   = Join-Path -Path $defaultDesktop1 -ChildPath $folderName1
$targetPath2   = Join-Path -Path $defaultDesktop2 -ChildPath $folderName2

$logPath = "C:\AVDSetup\log.txt"
if (!(Test-Path -Path "C:\AVDSetup")) {
    New-Item -ItemType Directory -Path "C:\AVDSetup" -Force | Out-Null
}

# フォルダが存在しない場合に新規作成1
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 create start."
try {
  if (!(Test-Path -Path $targetPath1)) {
      New-Item -ItemType Directory -Path $targetPath1 -Force | Out-Null
      Write-Host "Folder '$folderName1' created in Default user Desktop ($targetPath1)."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName1' created."
  } else {
      Write-Host "Folder '$folderName1' already exists at $targetPath1."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 create end.."

# フォルダが存在しない場合に新規作成2
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 create start."
try {
  if (!(Test-Path -Path $targetPath2)) {
      New-Item -ItemType Directory -Path $targetPath2 -Force | Out-Null
      Write-Host "Folder '$folderName2' created in Default user Desktop ($targetPath2)."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName2' created."
  } else {
      Write-Host "Folder '$folderName2' already exists at $targetPath2."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 create end.."

#### システム設定
# 時刻・日付などの表示形式が言語リストに追従するよう設定
Set-WinCultureFromLanguageListOptOut -OptOut $False

# デフォルトの入力方法を日本語IMEに変更
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

# システムロケールを日本 (ja-JP) に設定
Set-WinSystemLocale -SystemLocale ja-JP

# ようこそ画面と新規ユーザーアカウントにも現在の国際設定をコピー
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

# タイムゾーンを日本標準時(東京)に設定 -> Sysprepでリセットされている模様
# Set-TimeZone -Id "Tokyo Standard Time"
