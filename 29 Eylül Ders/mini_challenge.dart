void main(){

  final Set<String> cloudservices={
    "auth-service",
    "user-service",
    "product-service",
  };

  bool isProduction=true;

  final List<String> allServices=[
    ...cloudservices,
    if(isProduction) "vault-secret-manager",
  ];

  print(allServices);






}