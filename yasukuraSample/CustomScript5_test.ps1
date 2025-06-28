### カスタムフォルダ作成 
# Azure Virtual Desktop カスタムイメージ用スクリプト: デフォルトユーザーのデスクトップにフォルダを作成
# フォルダ名は必要に応じて変更してください
$folderName = "CustomFolder01"                              # 作成するフォルダ名
$defaultDesktop = "C:\Users\Default\Desktop"
$targetPath   = Join-Path -Path $defaultDesktop -ChildPath $folderName

$logPath = "C:\AVDSetup\log.txt"
if (!(Test-Path -Path "C:\AVDSetup")) {
    New-Item -ItemType Directory -Path "C:\AVDSetup" -Force | Out-Null
}

# フォルダが存在しない場合に新規作成
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

#### システム設定
# 時刻・日付などの表示形式が言語リストに追従するよう設定
Set-WinCultureFromLanguageListOptOut -OptOut $False

# デフォルトの入力方法を日本語IMEに変更
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

# システムロケールを日本 (ja-JP) に設定
