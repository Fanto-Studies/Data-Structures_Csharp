package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Print a Box in unicode
func printBox(text1 string, text2...string){
	padding := 2
	content := fmt.Sprintf("│ >_ %s %v ", text1, strings.Join(text2, " "))
	width := len(content) + padding

	// Drawing the box 
	top := "╭" + strings.Repeat("─", width-2) + "╮"
	middle := content + strings.Repeat(" ", width-len(content)-1) + "  │"
	bottom := "╰" + strings.Repeat("─", width-2) + "╯"

	fmt.Println(top)
  fmt.Println(middle)
  fmt.Println(bottom)

}

// Function to run commands into console
func runCommand(name string, args...string){
	cmd := exec.Command(name, args...)
	cmd.Stdout = nil
	cmd.Stderr = os.Stderr
	fmt.Println("")
	fmt.Println("Running the following command:\n")
	printBox(name,args...)
	error := cmd.Run()
	if error != nil {
		fmt.Printf("\n\033[31m  \033[0m Error running command: %s %v\n", name, args)
		os.Exit(1)
	}
}

func createSolution(solName string){
	
	// Create new folder
	err := os.Mkdir(solName, 0755)
	if err != nil {
		fmt.Printf("\n\033[31m  \033[0m Failed to create folder: %s\n", solName)
		os.Exit(1)
	}

	// Change directory
	err = os.Chdir(solName)
  if err != nil {
		fmt.Printf("\n\033[31m  \033[0m Failed to enter folder: %s\n", solName)
		os.Exit(1)
	}

	// Create solution
	runCommand("dotnet", "new", "sln", "--name", solName)
	fmt.Println("\n\033[32m  \033[0m Solution created successfully!")
	
}

func createProject(projName string){
	runCommand("dotnet", "new", "console", "-o", projName)
	fmt.Println("\n\033[32m  \033[0m Console Project created successfully!")
}

func createTestProject(projName string){
	testProjName := projName + "Tests"
	runCommand("dotnet", "new", "mstest", "-o", testProjName)
	fmt.Println("\n\033[32m  \033[0m Console Test Project created successfully!")
}

func configureProjects(projName string){
	testProjName := projName + "Tests"
	csprojProject := fmt.Sprintf("%s/%s.csproj", projName, projName)
	csprojTest := fmt.Sprintf("%s/%s.csproj", testProjName, testProjName)

	runCommand("dotnet", "sln", "add", csprojProject)
	fmt.Println("\n\033[32m  \033[0m Project configured into the Solution successfully!")

	runCommand("dotnet", "sln", "add", csprojTest)
	fmt.Println("\n\033[32m  \033[0m Test Project configured into the Solution successfully!")
}

func configureProjOnTest(projName string){
	testProjName := projName + "Tests"
	csprojProject := fmt.Sprintf("%s/%s.csproj", projName, projName)
	csprojTest := fmt.Sprintf("%s/%s.csproj", testProjName, testProjName)
	runCommand("dotnet", "add", csprojTest, "reference", csprojProject)
	fmt.Println("\n\033[32m  \033[0m Added Project reference into the Test Project successfully!")
}


// Main Function with the script
func main(){
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("")
	fmt.Println("\033[35m┌─────────────────────────────────┐\033[0m")
	fmt.Println("\033[35m│ .NET CONSOLE PROJECT GENERATOR  │\033[0m")
	fmt.Println("\033[35m└─────────────────────────────────┘\033[0m")
	fmt.Println("")

	// -> Solution Generation
	fmt.Print("1. Enter the Solution name (Ex: SolutionExample): ")
	fmt.Print(" ")
	solutionName, _ := reader.ReadString('\n')
	solutionName = strings.TrimSpace(solutionName)
	createSolution(solutionName)

	// -> Project Generation
	fmt.Print("\n 2. Enter the Project name (Ex: ProjectExample): ")
	fmt.Print(" ")
	projectName, _ := reader.ReadString('\n')
	projectName = strings.TrimSpace(projectName)
	createProject(projectName)

	// -> Test Project Generation
	createTestProject(projectName)

	// -> Configuring the project and tests into the solution
	configureProjects(projectName)

	// -> Configure the project reference inside the test project
	configureProjOnTest(projectName)

	// -> End of the program
	
	fmt.Println("")
	fmt.Println("\033[33m┌─────────────────────────────────────┐\033[0m")
	fmt.Println("\033[33m│  CONSOLE PROJECT CREATION COMPLETE! │\033[0m")
	fmt.Println("\033[33m└─────────────────────────────────────┘\033[0m")
	fmt.Println("")
	fmt.Println("Thank you for using this script, Give me a :star: on Github")
	fmt.Println("-> https://www.github.com/F4NT0/Csharp_Templates")
	fmt.Println("")

}
