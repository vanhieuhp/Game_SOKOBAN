package myPackage.java.main;

import myPackage.java.entity.Box;
import myPackage.java.entity.Player;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class CheckCollision {

    public int[][] mapTile;
    public List<Integer> pointAddress = new ArrayList<>();
    public List<Integer> boxAddress = new ArrayList<>();
    public Player player;
    public GamePanel gp;
    Box[] boxes;

    public CheckCollision(Player player, GamePanel gp, Box[] boxes) {
        this.player = player;
        this.gp = gp;
        this.boxes = boxes;

        mapTile = gp.map.getMapTile();

        String mapPath = "/myPackage/assets/checkpoint/" + gp.numOfMap + ".txt";
        loadCheckPointMap(mapPath);
    }

    public void loadCheckPointMap(String pathFile) {
        try {
            InputStream inputStream = getClass().getResourceAsStream(pathFile);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            String line = bufferedReader.readLine();
            while (line != null) {
                String numbers[] = line.split(" ");
                int element = Integer.parseInt(numbers[0]) * 10 + Integer.parseInt(numbers[1]);
                pointAddress.add(element);
                line = bufferedReader.readLine();
            }
            bufferedReader.close();

        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void checkCollision(int number) {
        if (number == 0 || number == 3) {
            player.collisionOn = false;
        } else {
            player.collisionOn = true;
        }
    }

    public void checkBox(int number, int col, int row, int index, int bCol, int bRow, boolean drawPointAgain) {

        if (number == 0 || number == 3) {
            boxes[index].locationX = col * gp.tileSize;
            boxes[index].locationY = row * gp.tileSize;
            mapTile[col][row] = 2;
            if (drawPointAgain) {
                mapTile[bCol][bRow] = 3;
            } else {
                mapTile[bCol][bRow] = 0;
            }
            player.collisionOn = false;
        } else {
            player.collisionOn = true;
        }
    }

    public int findBox(int aCol, int aRow) {
        int locationX = aCol * gp.tileSize;
        int locationY = aRow * gp.tileSize;
        int index = 0;
        for (int i = 0; i < boxes.length; i++) {
            if (boxes[i].locationX == locationX && boxes[i].locationY == locationY) {
                index = i;
            }
        }
        return index;
    }

    public void check(String direction) {

        int col = player.locationX / gp.tileSize;
        int row = player.locationY / gp.tileSize;
        switch (direction) {
            case "up":
                row -= 1;
                break;
            case "down":
                row += 1;
                break;
            case "left":
                col -= 1;
                break;
            case "right":
                col += 1;
                break;
        }
        int number = mapTile[col][row];
        if (number == 2) {
            boolean drawPointAgain = drawPointAgain(col, row);
            int index = findBox(col, row);
            int bCol = col, bRow = row;
            switch (direction) {
                case "up":
                    row -= 1;
                    break;
                case "down":
                    row += 1;
                    break;
                case "left":
                    col -= 1;
                    break;
                case "right":
                    col += 1;
                    break;
            }
            number = mapTile[col][row];
            checkBox(number, col, row, index, bCol, bRow, drawPointAgain);
        } else {
            checkCollision(number);
        }
    }

    public boolean drawPointAgain(int col, int row) {
        int value = col * 10 + row;
        for (int v : pointAddress) {
            if (v == value) {
                return true;
            }
        }
        return false;
    }

    public boolean checkWinGame() {
        boxAddress.clear();
        for (int i = 0; i < mapTile.length; i++) {
            for (int j = 0; j < mapTile[i].length; j++) {
                if (mapTile[i][j] == 2) {
                    int number = i * 10 + j;
                    boxAddress.add(number);
                }
            }
        }
        if (boxAddress.containsAll(pointAddress)) {
            return true;
        } else {
            return false;
        }
    }


}
