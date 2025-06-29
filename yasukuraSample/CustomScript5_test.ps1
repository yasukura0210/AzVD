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

##### カスタムフォルダ作成 #####
$folderName = "CustomFolder01"
$defaultDesktop = "C:\Users\Default\Desktop"
$targetPath   = $defaultDesktop + "\" + $folderName 

$logPath = "C:\AVDSetup\log.txt"
if (!(Test-Path -Path "C:\AVDSetup")) {
    New-Item -ItemType Directory -Path "C:\AVDSetup" -Force | Out-Null
}

Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 create start. TargetPath is ($targetPath). FolderName is ($folderName)."
try {
  if (!(Test-Path -Path $targetPath)) {
      New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
      Write-Host "Folder '$folderName' created in Default user Desktop ($targetPath)."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName' created."
  } else {
      Write-Host "Folder '$folderName' already exists at $targetPath."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 create end. TargetPath is ($targetPath). FolderName is ($folderName)."

$folderName = "CustomFolder02"
$defaultDesktop = "C:\Users\Public\Desktop"
$targetPath   = $defaultDesktop + "\" + $folderName 

Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 create start. TargetPath is ($targetPath). FolderName is ($folderName)."
try {
  if (!(Test-Path -Path $targetPath)) {
      New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
      Write-Host "Folder '$folderName' created in Default user Desktop ($targetPath)."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName' created."
  } else {
      Write-Host "Folder '$folderName' already exists at $targetPath."
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 create end. TargetPath is ($targetPath). FolderName is ($folderName)."
