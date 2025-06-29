####### 以下はOS設定 #######
#### システム設定
# 時刻・日付などの表示形式が言語リストに追従するよう設定
Set-WinCultureFromLanguageListOptOut -OptOut $False

# デフォルトの入力方法を日本語IMEに変更
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

# システムロケールを日本 (ja-JP) に設定
Set-WinSystemLocale -SystemLocale ja-JP

# ようこそ画面と新規ユーザーアカウントにも現在の国際設定をコピー
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

# タイムゾーンを日本標準時(東京)に設定 -> Sysprepでリセットされている模様なので無意味
# Set-TimeZone -Id "Tokyo Standard Time"

##### カスタムフォルダ作成 #####
# C:\Users\Default\Desktop」へのフォルダ作成 : 各ユーザーのデフォルトプロファイルとしてのデスクトップ
# C:\Users\Public\Desktop」へのフォルダ作成 : パブリックデスクトップ（ここに作成したショートカットやフォルダはそのマシン上の全ユーザーのデスクトップに表示される）

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

# フォルダ作成 : folderName1
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 creation start. TargetPath is $targetPath1. FolderName is $folderName1."
try {
  if (!(Test-Path -Path $targetPath1)) {
      New-Item -ItemType Directory -Path $targetPath1 -Force | Out-Null
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName1' created."
  } else {
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder1 creation end. TargetPath is $targetPath1. FolderName is $folderName1."

# フォルダ作成 : folderName2
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 creation start. TargetPath is $targetPath2. FolderName is $folderName2."
try {
  if (!(Test-Path -Path $targetPath2)) {
      New-Item -ItemType Directory -Path $targetPath2 -Force | Out-Null
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder '$folderName2' created."
  } else {
      Add-Content -Path $logPath -Value "[$(Get-Date)] Folder already exists."    
  }
} catch {
    Add-Content -Path $logPath -Value "[$(Get-Date)] Error: $_"
}
Add-Content -Path $logPath -Value "[$(Get-Date)] Folder2 creation end. TargetPath is ($targetPath2). FolderName is $folderName2."
