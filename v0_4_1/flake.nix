{
  description = ''NESM stands for Nim's Easy Serialization Macro. The macro allowing generation of serialization functions by one line of code!'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nesm-v0_4_1.flake = false;
  inputs.src-nesm-v0_4_1.ref   = "refs/tags/v0.4.1";
  inputs.src-nesm-v0_4_1.owner = "xomachine";
  inputs.src-nesm-v0_4_1.repo  = "NESM";
  inputs.src-nesm-v0_4_1.dir   = "";
  inputs.src-nesm-v0_4_1.type  = "gitlab";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nesm-v0_4_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nesm-v0_4_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}