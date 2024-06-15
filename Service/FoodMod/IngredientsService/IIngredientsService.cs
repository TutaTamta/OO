using DTO.FoodMod.IngredientsDTO;

namespace Service.FoodMod.IngredientsService;



public interface IIngredientsService
{
    IngredientsDto GetIngredients(long id);
    List<IngredientsDto> GetIngredients();
    void InsertIngredients(CreateIngredientsDto dto);
    void UpdateIngredients(UpdateIngredientsDto dto);
    void DeleteIngredients(long id);
}