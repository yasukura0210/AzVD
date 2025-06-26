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
