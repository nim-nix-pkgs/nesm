{
  description = ''A macro for generating [de]serializers for given objects'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nesm-v0_4_10.flake = false;
  inputs.src-nesm-v0_4_10.owner = "xomachine";
  inputs.src-nesm-v0_4_10.ref   = "refs/tags/v0.4.10";
  inputs.src-nesm-v0_4_10.repo  = "NESM";
  inputs.src-nesm-v0_4_10.type  = "gitlab";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nesm-v0_4_10"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nesm-v0_4_10";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}