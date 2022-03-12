{
  description = ''A macro for generating [de]serializers for given objects'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nesm-v0_3_1.flake = false;
  inputs.src-nesm-v0_3_1.owner = "xomachine";
  inputs.src-nesm-v0_3_1.ref   = "refs/tags/v0.3.1";
  inputs.src-nesm-v0_3_1.repo  = "NESM";
  inputs.src-nesm-v0_3_1.type  = "gitlab";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nesm-v0_3_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nesm-v0_3_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}