package myPackage.java.map;

import myPackage.java.main.GamePanel;
import myPackage.java.main.UtilityTool;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

public class TileManager {
    public Tile[] tiles;
    GamePanel gp;
    public int mapTile[][];
    public final Map map;

    public TileManager(GamePanel gp) {
        this.gp = gp;
        tiles = new Tile[10];
        getTileImage();
        this.map = gp.map;
        mapTile = map.getMapTile();
    }

    public void getTileImage() {
        setTileImage(0, "road", false);
        setTileImage(1, "wall", true);
        setTileImage(2, "road", false);
        setTileImage(3, "point", false);
    }

    public void setTileImage(int index, String imagePath, boolean collision) {
        UtilityTool utilityTool = new UtilityTool();
        try {
            tiles[index] = new Tile();
            tiles[index].image = ImageIO.read(getClass().getResourceAsStream("/myPackage/assets/image/" + imagePath + ".png"));
            tiles[index].image = utilityTool.scaleImage(tiles[index].image, gp.tileSize, gp.tileSize);
            tiles[index].collision = collision;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void draw(Graphics2D g2) {
        int col = 0;
        int row = 0;

        BufferedImage image = null;
        while (col < map.maxCol && row < map.maxRow) {
            int number = mapTile[col][row];
            image = tiles[number].image;
            int locationX = col * gp.tileSize;
            int locationY = row * gp.tileSize;

            g2.drawImage(image, locationX, locationY, gp.tileSize, gp.tileSize, null);
            col++;
            if (col == map.maxCol) {
                col = 0;
                row++;
            }
        }
    }
}
