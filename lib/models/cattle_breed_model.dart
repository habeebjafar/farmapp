class CattleBreedModel{
  int? id;
  String? cattleBreed;

   createMap() {
    return {
      if(id != null) "id" : id.toString(),
      "cattleBreed": this.cattleBreed,
      
     
      
    };
  }

}