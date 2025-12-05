package cup

import (
	"strings"
	"tool/cli"
	"tool/exec"
)

RunPrint: {
	// name `exec.Run` task as `runP` to trigger print command
	runP?: _
	if (runP & exec.Run) != _|_ {
		print: cli.Print & {
			text: *"#!\(runP.cmd)" | _
			if (runP.cmd & string) == _|_ {
				text: *("#!" + strings.Join(runP.cmd, " ")) | _
			}
		}
	}

}

PrintRun: {
	CMD=[_]: RunPrint & {
		// declare task `printR: _` to print command from all `exec.Run` tasks
		printR?: cli.Print & {
			text: strings.Join([for _, task in CMD if (task & exec.Run) != _|_ {"#!\(task.cmd)"}], "\n")
		}
		...
	}
}
