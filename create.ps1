# --------------------
# BASIC CONFIGURATION
# -------------------

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Enable UTF-8 in the console



# ------------------------
# POWERSHELL INTRODUCTION
# ------------------------

Write-Host ''
Write-Host ''
Write-Host '/--------------------------------\' -ForegroundColor Magenta
Write-Host '| .NET CONSOLE PROJECT GENERATOR |' -ForegroundColor Magenta
Write-Host '\--------------------------------/' -ForegroundColor Magenta
Write-Host ''
Write-Host ''


# ---------------------------
# GENERATION OF THE SOLUTION 
# ---------------------------

Write-Host ' 1. CREATE SOLUTION PROJECT ' -ForegroundColor Blue
Write-Host ''
Write-Host 'Enter the Solution name (Ex: SolutionExample): ' -ForegroundColor White
$solutionName = Read-Host '> '

mkdir $solutionName # create the folder of the solution.
cd $solutionName # enter into the folder of the solution.
dotnet new sln --name $solutionName # create the solution file.

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Solution Created Successfully!' -ForegroundColor White
Write-Host ''

# -------------------------------------------
# GENERATE THE SCRIPT TO CREATE NEW PROJECTS
# ------------------------------------------

Write-Host ' -> Creating inside script to generate new projects...' -ForegroundColor Yellow
Write-Host ''

$genscript = @" 
# -----------------------------------
# CREATE NEW PROJECT INSIDE THIS ONE
# -----------------------------------

Write-Host ''
Write-Host ''
Write-Host '/---------------------------\' -ForegroundColor Magenta
Write-Host '| CREATE NEW PROJECT INSIDE |' -ForegroundColor Magenta
Write-Host '\---------------------------/' -ForegroundColor Magenta
Write-Host ''
Write-Host ''

# ----------------------------
# CREATING NEW CONSOLE PROJECT
# ----------------------------

Write-Host ''
Write-Host ' -> CREATE CONSOLE PROJECT ' -ForegroundColor Blue
Write-Host ''
Write-Host 'Enter the Project name (Ex: ProjectExample): ' -ForegroundColor White
$projectName = Read-Host '> '
dotnet new console -o $projectName # create the project on the Solution folder.

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Console Project Created Successfully!' -ForegroundColor White

# --------------------------------------------
# CONFIGURING THE PROJECTS INTO THE SOLUTION
# --------------------------------------------

Write-Host ' -> Configuring the projects inside the solution...' -ForegroundColor Yellow

dotnet sln add $projectName/$projectName.csproj # add the project into the solution.

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Project added into the solution!' -ForegroundColor White


# ------------------------------------
# GENERATION OF THE HELLO WORLD CODE
# ------------------------------------

Write-Host ' -> Creating a hello world template into the program.cs file...' -ForegroundColor Yellow

$code = @"
namespace $projectName
{
    public class Program
    {
      public static string GetHelloWorld()
      {
          return `"Hello World!`";
      }

      public static void Main(string[] args)
      {
          string test = GetHelloWorld();
          Console.WriteLine(test);
      }
    }
}

"@

$genscript | Out-File -FilePath generate-project.ps1

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Powershell script Created Successfully!' -ForegroundColor White
Write-Host ''

# ---------------------------
# GENERATION OF THE PROJECT
# ---------------------------

Write-Host ''
Write-Host ' 2. CREATE CONSOLE PROJECT ' -ForegroundColor Blue
Write-Host ''
Write-Host 'Enter the Project name (Ex: ProjectExample): ' -ForegroundColor White
$projectName = Read-Host '> '
dotnet new console -o $projectName # create the project on the Solution folder.

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Console Project Created Successfully!' -ForegroundColor White
Write-Host ''

# --------------------------------
# GENERATION OF THE TEST PROJECT
# --------------------------------

Write-Host ' 3. CREATE TEST PROJECT ' -ForegroundColor Blue
Write-Host ''
Write-Host ' -> Creating Automatically the mstest Test Project...' -ForegroundColor Yellow
Write-Host ''
$testProjectName = $projectName + 'Tests'
dotnet new mstest -o $testProjectName # create the test project on the Solution folder.

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Test Project Created Successfully!' -ForegroundColor White
Write-Host ''

# --------------------------------------------
# CONFIGURING THE PROJECTS INTO THE SOLUTION
# --------------------------------------------

Write-Host ' -> Configuring the projects inside the solution...' -ForegroundColor Yellow
Write-Host ''

dotnet sln add $projectName/$projectName.csproj # add the project into the solution.

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Project added into the solution!' -ForegroundColor White
Write-Host ''

dotnet sln add $testProjectName/$testProjectName.csproj # add the test project into the solution.

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Test Project added into the solution!' -ForegroundColor White
Write-Host ''

# ----------------------------------------------
# CONFIGURING THE PROJECT INTO THE TEST PROJECT
# ----------------------------------------------

Write-Host ' -> Configuring the project inside the test project...' -ForegroundColor Yellow
Write-Host ''

dotnet add $testProjectName/$testProjectName.csproj reference $projectName/$projectName.csproj # add the project reference into the test project.

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Project reference added into the test project!' -ForegroundColor White
Write-Host ''

# ------------------------------------
# GENERATION OF THE HELLO WORLD CODE
# ------------------------------------

Write-Host ' -> Creating a hello world template into the program.cs file...' -ForegroundColor DarkYellow
Write-Host ''

$code = @"
namespace $projectName
{
    public class Program
    {
      public static string GetHelloWorld()
      {
          return `"Hello World!`";
      }

      public static void Main(string[] args)
      {
          string test = GetHelloWorld();
          Console.WriteLine(test);
      }
    }
}
"@

$code | Out-File -FilePath $projectName/Program.cs

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Created the Hello World Template!' -ForegroundColor White
Write-Host ''

# -----------------------------
# GENERATION OF THE TEST CODE
# -----------------------------

Write-Host ' -> Adding template test into the test project' -ForegroundColor DarkYellow
Write-Host ''

$testCode = @"
using Microsoft.VisualStudio.TestTools.UnitTesting;
using $projectName;

namespace $testProjectName;

[TestClass]
public class UnitTest1
{
    [TestMethod]
    public void TestHelloWorld()
    {
        // Arrange
        //Program program = new Program();
        
        // Act
        string result = Program.GetHelloWorld();

        // Assert
        Assert.AreEqual("Hello World!", result);
    }
}
"@

$testCode | Out-File -FilePath $testProjectName/UnitTest1.cs

Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Test example added into the test project!' -ForegroundColor White
Write-Host ''

# ---------------------------------------
# TESTING THE PROJECT USING RUN COMMAND
# ---------------------------------------

Write-Host ' -> Running the project to validate the hello world!' -ForegroundColor Yellow
Write-Host ''

$projectCsproj = $projectName + '.csproj'
dotnet run --project $projectName/$projectCsproj

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Project runned Successfully!' -ForegroundColor White
Write-Host ''

# ---------------------------------------
# TESTING THE TESTS USING TEST COMMAND
# ---------------------------------------

Write-Host ' -> Running the test project' -ForegroundColor Yellow
Write-Host ''

$testProjectCsproj = $testProjectName + '.csproj'
dotnet test $testProjectName/$testProjectCsproj

Write-Host ''
Write-Host '[OK]' -ForegroundColor Green -NoNewline
Write-Host ' Test Project runned Successfully!' -ForegroundColor White
Write-Host ''

# ----------------------------------
# COMPLETED AND BACK TO ROOT FOLDER
# ----------------------------------

Write-Host ''
Write-Host ' -> PROJECT CREATION COMPLETE! <- ' -ForegroundColor Magenta
Write-Host ''
Write-Host 'Script generated by: F4NT0 - Give a star in the https://github.com/F4NT0/CSharp-Template'
Write-Host ''
