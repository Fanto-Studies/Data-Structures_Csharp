package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Function to run commands into console
func runCommand(name string, args...string){
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	error := cmd.Run()
	if error != nil {
		fmt.Printf("\033[31m  \033[0m Error running command: %s %v\n", name, args)
	}
}

// Main Function with the script
func main(){
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("┌─────────────────────────────────┐")
	fmt.Println("│ .NET CONSOLE PROJECT GENERATOR  │")
	fmt.Println("└─────────────────────────────────┘")
	fmt.Println("")


	fmt.Print(" 1. Enter the Solution name (Ex: SolutionExample): ")
	fmt.Print(" ")
	solutionName, _ := reader.ReadString('\n')
	solutionName = strings.TrimSpace(solutionName)

	// Create new folder
	err := os.Mkdir(solutionName, 0755)
	if err != nil {
		fmt.Printf("\033[31m  \033[0m Failed to create folder: %s\n", solutionName)
		os.Exit(1)
	}

	// Change directory
	err = os.Chdir(solutionName)
  if err != nil {
		fmt.Printf("\033[31m  \033[0m Failed to enter folder: %s\n", solutionName)
		os.Exit(1)
	}

	// Create solution
	runCommand("dotnet", "new", "sln", "--name", solutionName)
	fmt.Println("\033[32m  \033[0m Solution created successfully!")


}
