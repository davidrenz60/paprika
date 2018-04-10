class Recipe < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true
  validates :photo_url, presence: true
  validates :created, presence: true
  validates :uid, presence: true
  validates_uniqueness_of :uid
end

 # { "rating"=>5,
 #   "photo_hash"=>
 #    "78b15689aeaa362818222a957d16885a4f3f09e9800cf3bf0372ab7ed8fa170e",
 #   "on_favorites"=>false,
 #   "photo"=>
 #    "7DBDD189-CBD3-4FE7-82BC-6F085ABAD8B8-2194-0000027AF758395C.jpg",
 #   "uid"=>
 #    "B7981383-1C5B-439B-A2E7-14FEA1AC5330-1816-000001D9A7999687",
 #   "scale"=>"1/1",
 #   "ingredients"=>
 #    "1 cup kosher salt or ½ cup table salt\n1 cup granulated sugar\n10 bone in chicken thighs (about 3 ½ pounds), skin and excess fat removed\n6 slices high-quality sandwich bread slice, cut into ½-inch dice (about 3 cups)\n3 tablespoons unsalted butter, melted\n1 pound dried flageolet beans or Great Northern beans, picked over and rinsed\n1 medium onion, peeled and left whole\n1 medium head garlic, outer papery skin removed and top ½ inch sliced off\n1 teaspoon table salt\n½ teaspoon ground black pepper\n6 slices bacon (about 6 ounces), chopped medium\n1 pound boneless pork loin roast (blade-end), trimmed of excess fat and silver skin and cut into 1-inch pieces\n1 small onion, chopped fine\n2 medium cloves garlic, minced or pressed through garlic press\n1 can (14 ½ ounces) diced tomatoes, drained\n1 tablespoon tomato paste\n1 sprig fresh thyme\n1 bay leaf\n¼ teaspoon ground cloves\nGround black pepper\n3 ½ cups chicken stock or canned low-sodium chicken broth\n1 ½ cup dry white wine\n½ pound kielbasa sausage, halved lengthwise and cut into ¼-inch slices",
 #   "is_pinned"=>nil,
 #   "source"=>"Cooksillustrated.com",
 #   "total_time"=>nil,
 #   "hash"=>
 #    "3aae689d7c6d9b32eb9bc63ade0b3524a575a79d802ca2531d95363e0fe54d1f",
 #   "description"=>nil,
 #   "source_url"=>
 #    "http://www.cooksillustrated.com/recipes/470-simplified-cassoulet-with-pork-and-kielbasa?ref=new_search_experience_1&incode=MCSCM00L0",
 #   "difficulty"=>"",
 #   "on_grocery_list"=>nil,
 #   "in_trash"=>nil,
 #   "directions"=>
 #    "1. Brining the Chicken: In gallon-sized zipper-lock plastic bag, dissolve salt and sugar in 1 quart cold water. Add chicken, pressing out as much air as possible; seal and refrigerate until fully seasoned, about 1 hour. Remove chicken from brine, rinse thoroughly under cold water, and pat dry with paper towels. Refrigerate until ready to use.\n\n2. Preparing the Topping: While chicken is brining, adjust oven rack to upper-middle position; heat oven to 400 degrees. Mix bread crumbs and butter in small baking dish. Bake, tossing occasionally, until light golden brown and crisp, 8 to 12 minutes. Cool to room temperature; set aside.\n\n3. Bring the beans, whole onion, garlic head, salt, pepper and 8 cups water to a boil in a stockpot or Dutch oven over high heat. Cover, reduce the heat to medium-low, and simmer until the beans are almost fully tender, 1 1/4 to 1 1/2 hours. Drain the beans and discard the onion and garlic.\n\n4. While the beans are cooking, fry the bacon in a Dutch oven over medium heat until just beginning to crisp and most of the fat has rendered, 5 to 6 minutes. Using a slotted spoon, add half of the bacon to the pot with the beans; transfer the remaining bacon to a paper towel-lined plate and set aside. Increase the heat to medium-high; when the bacon fat is shimmering, add half of the chicken thighs, fleshy-side down; cook until lightly browned, 4 to 5 minutes. Using tongs, turn chicken pieces and cook until lightly browned on second side, 2 to 3 minutes longer. Transfer chicken to large plate; repeat with remaining thighs and set aside. Drain off all but 2 tablespoons fat from pot. Return pot to medium heat; add pork pieces and cook, stirring occasionally, until lightly browned, about 5 minutes. Add chopped onion and cook, stirring occasionally, until softened, 3 to 4 minutes. Add minced garlic, tomatoes, tomato paste, thyme, bay leaf, cloves, and pepper to taste; cook until fragrant, about 1 minute. Stir in chicken broth and wine, scraping up browned bits off bottom of pot with wooden spoon. Submerge the chicken in the pot, adding any accumulated juices. Increase the heat to high and bring to a boil, then reduce the heat to low, cover, and simmer about 40 minutes. Remove the cover and continue to simmer until the chicken and pork are fully tender, 20 to 30 minutes more.\n\n5. Gently stir the kielbasa, drained beans and reserved bacon into the pot with the chicken and pork; remove and discard the thyme and bay leaf and adjust the seasonings with salt and pepper. Sprinkle the croutons evenly over the surface and bake at 425, uncovered, until the flavors have melded and the croutons are deep golden brown, about 15 minutes. Let stand 10 minutes and serve.",
 #   "categories"=>
 #    ["69DB0B9F-0D20-425F-A505-A93DB4813AA9-1364-000001BA525099EA",
 #     "FA629005-63E0-4202-B28F-0D7557303D46-2194-0000027AED0D6BE7"],
 #   "photo_url"=>
 #    "http://uploads.paprikaapp.com.s3.amazonaws.com/128394/7DBDD189-CBD3-4FE7-82BC-6F085ABAD8B8-2194-0000027AF758395C.jpg?Signature=IGqwuv4u3DA1aBlbZl68nhbsB6Y%3D&Expires=1523138464&AWSAccessKeyId=AKIAJA4A42FBJBMX5ARA",
 #   "cook_time"=>"",
 #   "name"=>"Cassoulet with Pork and Kielbasa",
 #   "created"=>"2016-01-16 11:33:26",
 #   "notes"=>nil,
 #   "photo_large"=>nil,
 #   "image_url"=>
 #    "assets-library://asset/asset.JPG?id=BA03A983-58EF-4AA7-9FCE-711103257601&ext=JPG",
 #   "prep_time"=>"",
 #   "servings"=>"Serves 8",
 #   "nutritional_info"=>""
 # }