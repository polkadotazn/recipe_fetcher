# README

My app is located at http://recipe-finder-lx.herokuapp.com/.

You can find all searches at http://recipe-finder-lx.herokuapp.com/searches.

In order to query any ingredient, use "search_text" as so: http://recipe-finder-lx.herokuapp.com/searches?search_text=chocolate. This will bring up 50 results. If you revisit this page you will see these results again with a different status code/message.

In order to sort the recipe titles alphabetically or reverse alphabetically, use sort=asc or sort=desc: http://recipe-finder-lx.herokuapp.com/searches?search_text=habanero&sort=desc

If you would like to find recipes that have x number of ingredients or fewer, use filter with an integer: http://recipe-finder-lx.herokuapp.com/searches?search_text=gouda&filter=7

You can also use sort and filter together.

Each recipe lists the title and ingredients, but you will have to go to the listed link in order to find the instructions for making the actual recipe. I hope you find something delicious to make!
