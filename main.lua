function love.load()
--cellsize I like working with
cellsize=32
--width and height
w=32
h=32
--player information
player={x=0,y=0,w=cellsize,h=cellsize}
--map array
tilemap={
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,0,0},
        {1,1,1,1,1,0,0,1,1,1},
        {1,1,1,1,1,1,1,1,1,1}
        }
end

function love.update()
  --supposed to be aabb definitions
left=player.x
right=player.x+cellsize
top=player.y
bottom=player.y+cellsize

left2=0
right2=cellsize
top2=0
bottom2=cellsize



--controls
if love.keyboard.isDown('up') then
  player.y = player.y - 5
end
if love.keyboard.isDown('down') then
  player.y = player.y + 5
end
if love.keyboard.isDown('left') then
  player.x = player.x - 5
end
if love.keyboard.isDown('right') then
  player.x = player.x + 5
end

--supposed to be aabb collision comparing the tile array to the player object
if tile == 1 and left < right2 and right > left2 and top < bottom2 and bottom > top2 then
              print ('Collision')
            else
              print('nope')
            end
end
function love.draw() 
  --the tile array
    for i,row in ipairs(tilemap) do
      for j,tile in ipairs(row) do
        
        tile_x=tile
        tile_y=row
        
            
        --changes the color of the tiles based on what they are defined as in the tilemap array
            if tile ~= -1 then
              if tile ==0 then
                love.graphics.setColor(25,25,255)
              elseif tile ==1  then
                 love.graphics.setColor(25,255,255)
                end
                --prints the tile array
              love.graphics.rectangle("line", (j-1)*cellsize,(i-1)*cellsize, w, h)
            end
         
        end
        
    end
    --the player character object
love.graphics.setColor(255,25,25)
love.graphics.rectangle('line',player.x,player.y,cellsize,cellsize)
end
