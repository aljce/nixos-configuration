{ python3Packages, fetchFromGitHub }:
with python3Packages;
with {
  inputs = [ boto3 botocore ];
};
buildPythonPackage rec {
  name = "aws-mfa";
  src = fetchFromGitHub {
    repo = "aws-mfa";
    owner = "broamski";
    rev = "5334deb170204c14922b25b22617c2b1e909d0f6";
    sha256 = "1jz2zc2acy764kc9rikx594naka42pik0nam1bk30hn5gxwf8vv1";
  };
  buildInputs = inputs;
  propagatedBuildInputs = inputs;
}
