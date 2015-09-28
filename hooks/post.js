var fs = require('fs-extra');
var path = require('path');
var done = false;
exports.hook = function(){
  // generic json reading function
  function read_json (file_path) {
      var temp;
      //console.log(path.resolve(file_path))
      temp = fs.readFileSync(path.resolve(file_path));
      return JSON.parse(temp); // file_path is the json object because of a bug
  };

  function done() {
    done = true;
  }
  //read our config file
  var config_file = "./hooks/config.json";
  //var config_file = "{\"dirs\": {\"gh_pages\": \"../gh-pages\"\,\"bin\" : \"../bin/web\"\,\"git_files\" : \"./git_files\"}}";

  var config = read_json(config_file)
  var dirs = config.dirs

  console.log("- Source dir: "+ dirs.bin+" Target dir: "+ dirs.gh_pages)
  fs.copy(dirs.bin,dirs.gh_pages, function copy_site(err){
  	if (err) throw err //failed copy
  	console.log("- Project copied")
    console.log("- Copying git_files...")
    fs.readdir(dirs.git_files,function copy_git_files(err,files){
      if (err) throw err
      for (var i = 0; i<files.length;i++) {
        var file = files[i]
        console.log("- Copied "+file)
        fs.copy(path.join(dirs.git_files,file),path.join(dirs.gh_pages,file), function copy_file(err){
      		if (err) throw err
      	})
      }
      done()

    })
  })
}
