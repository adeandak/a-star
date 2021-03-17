const {spawn} = require('child_process');

function runLisp(edoIn,edoFin){
            
    console.log(`(executeSearch '${edoIn} '${edoFin})`);
    let ls = spawn('clisp', ['-q','-i', './astar8.fas', '-x', `(executeSearch '${edoIn} '${edoFin})`])
    ls.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    ls.stderr.on('data', (data) => {
        console.log(`stderr: ${data}`);
    });
      
    ls.on('close', (code) => {
        console.log(`child process exited with code ${code}`);
    });
}

runLisp('((1 2 3)(4 0 5)(6 7 8))','((1 2 4)(5 3 8)(0 6 7))')