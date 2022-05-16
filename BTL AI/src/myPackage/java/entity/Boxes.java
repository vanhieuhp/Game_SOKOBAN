package myPackage.java.entity;

import myPackage.java.main.GamePanel;
import myPackage.java.map.Map;

import java.awt.*;

public class Boxes {
    public Box[] boxes;
    GamePanel gp;
    public int tileMap[][];
    Map map;

    public Boxes(GamePanel gp) {
        this.gp = gp;
        map = gp.map;
        tileMap = map.getMapTile();
        setBoxNo();
        setLocation();
    }

    public void setBoxNo() {
        int count = 0;
        for (int i = 0; i < tileMap.length; i++) {
            for (int value : tileMap[i]) {
                if (value == 2) {
                    count++;
                }
            }
        }
        boxes = new Box[count];
    }

    public void setLocation() {
        int count = 0;
        for (int i = 0; i < tileMap.length; i++) {
            for (int j = 0; j < tileMap[i].length; j++) {
                if (tileMap[i][j] == 2) {
                    boxes[count] = new Box();
                    boxes[count].locationX = i * gp.tileSize;
                    boxes[count].locationY = j * gp.tileSize;
                    count++;
                }
            }
        }
    }

    public void draw(Graphics2D g2) {
        for (int i = 0; i < boxes.length; i++) {
            g2.drawImage(boxes[i].image, boxes[i].locationX, boxes[i].locationY, gp.tileSize, gp.tileSize, null);
        }
    }
}
