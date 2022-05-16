package myPackage.java.main;

import myPackage.java.entity.Player;
import myPackage.java.map.Map;

import java.util.ArrayList;
import java.util.List;

public class BestFirstSearch {

    public GamePanel gp;
    public Player player;
    public CheckCollision checkCollision;
    public int locationX;
    public int locationY;
    private List<String> stageFather = new ArrayList<>();
    private int[][] virtualFatherMap;
    private int[][] abilityMove = new int[4][2];
    private Map map;
    private int[][] virtualMap;

    public BestFirstSearch(GamePanel gp, Player player) {
        this.gp = gp;
        this.player = player;
        this.checkCollision = player.checkCollision;
        this.locationX = player.locationX / gp.tileSize;
        this.locationY = player.locationY / gp.tileSize;
        this.map = new Map(gp.numOfMap);
        this.virtualMap = map.getMapTile();
        this.virtualFatherMap = map.getMapTile();
    }

    public void setAbilityMove() {
        int col = player.locationX / gp.tileSize;
        int row = player.locationY / gp.tileSize;
        for (int i = 0; i < 4; i ++) {
            abilityMove[i][0] = 0;
        }
        if (setLeftMove(col, row)) {
            abilityMove[0][0] = 1;
        }
        if (setUpMove(col, row)) {
            abilityMove[1][0] = 1;
        }
        if (setRightMove(col, row)) {
            abilityMove[2][0] = 1;
        }
        if (setDownMove(col, row)) {
            abilityMove[3][0] = 1;
        }
    }

    public void virtualMove() {
        String direction = "";
        for (int i = 0; i < 4; i++) {

            if (abilityMove[i][0] == 1 ) {
                if (abilityMove[i][1] == 1) {

                }
            }
        }
    }

    public void leftMove() {
        if (abilityMove[0][0] == 1) {
            virtualFatherMap = virtualMap;
            if (abilityMove[0][1] == 1) {

            }
        }
    }

    public boolean setLeftMove(int locationX, int locationY) {
        locationX -= 1;
        if (virtualMap[locationX][locationY] == 1) {
            return false;
        } else if (virtualMap[locationX][locationY] == 2) {
            locationX -= 1;
            if(checkBoxAndWall(locationX, locationY)) {
                abilityMove[0][1] = 1;
                return true;
            } else {
                return false;
            }
        } else {
            abilityMove[0][1] = 0;
            return true;
        }
    }

    public boolean setUpMove(int locationX, int locationY) {
        locationY -= 1;
        if (virtualMap[locationX][locationY] == 1) {
            return false;
        } else if (virtualMap[locationX][locationY] == 2) {
            locationY -= 1;
            if(checkBoxAndWall(locationX, locationY)) {
                abilityMove[1][1] = 1;
                return true;
            } else {
                return false;
            }
        } else {
            abilityMove[1][1] = 0;
            return true;
        }
    }

    public boolean setRightMove(int locationX, int locationY) {
        locationX += 1;
        if (virtualMap[locationX][locationY] == 1) {
            return false;
        } else if (virtualMap[locationX][locationY] == 2) {
            locationY += 1;
            if(checkBoxAndWall(locationX, locationY)) {
                abilityMove[2][1] = 1;
                return true;
            } else {
                return false;
            }
        } else {
            abilityMove[2][1] = 0;
            return true;
        }
    }

    public boolean setDownMove(int locationX, int locationY) {
        locationY += 1;
        if (virtualMap[locationX][locationY] == 1) {
            return false;
        } else if (virtualMap[locationX][locationY] == 2) {
            locationY += 1;
            if(checkBoxAndWall(locationX, locationY)) {
                abilityMove[3][1] = 1;
                return true;
            } else {
                return false;
            }
        } else {
            abilityMove[3][1] = 0;
            return true;
        }
    }

    public boolean checkBoxAndWall(int locationX, int locationY) {
        if (virtualMap[locationX][locationY] == 1) {
            return false;
        } else if (virtualMap[locationX][locationY] == 2) {
            return false;
        } else {
            return true;
        }
    }

}
