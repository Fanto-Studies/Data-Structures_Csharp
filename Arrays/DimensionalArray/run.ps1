# ------------
# RUN PROJECT
# ------------

Write-Host ''
Write-Host '-> Running dotnet project...'
Write-Host ''

dotnet build -nologo -v quiet >$null 2>&1 # Build project behind the scenes
dotnet run -nologo -v quiet # Run Project without messages or informations

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Project runned Successfully!' -ForegroundColor White


