param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    [Parameter(Mandatory=$false)]
    [string]$Version = "net8.0"
)

Write-Host "Start creating solution $Name"

dotnet new sln -o $Name
Set-Location $Name

Write-Host "Solution $Name created"

dotnet new webapi -o "$Name.Api" -f $Version
dotnet new classlib -o "$Name.Contracts" -f $Version
dotnet new classlib -o "$Name.Infrastructure" -f $Version
dotnet new classlib -o "$Name.Application" -f $Version
dotnet new classlib -o "$Name.Domain" -f $Version

dotnet sln add (Get-ChildItem -Recurse **\*.csproj)

dotnet add ".\$Name.Api" reference ".\$Name.Contracts" ".\$Name.Application" ".\$Name.Infrastructure"
dotnet add ".\$Name.Infrastructure" reference ".\$Name.Application"
dotnet add ".\$Name.Application" reference ".\$Name.Domain"
