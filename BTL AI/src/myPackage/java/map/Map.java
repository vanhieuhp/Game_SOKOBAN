package myPackage.java.map;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Map {

    int[][] mapTile;
    public int maxCol, maxRow;
    public int positionX, positionY;
    public String mapPath;

    public Map(int mapLevel) {
        mapPath = "/myPackage/assets/map/" + mapLevel + ".txt";
        loadMap(mapPath);
    }

    public void loadMap(String pathFile) {
        try {
            InputStream inputStream = getClass().getResourceAsStream(pathFile);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            int col = 0;
            int row = 0;
            String line = bufferedReader.readLine();
            String[] sizes = line.split(" ");
            maxCol = Integer.parseInt(sizes[0]);
            maxRow = Integer.parseInt(sizes[1]);

            mapTile = new int[maxCol][maxRow];

            line = bufferedReader.readLine();
            String positions[] = line.split(" ");
            positionX = Integer.parseInt(positions[0]);
            positionY = Integer.parseInt(positions[1]);
            while (col < maxCol && row < maxRow) {
                String lines = bufferedReader.readLine();
                while (col < maxCol) {
                    String numbers[] = lines.split(" ");
                    int num = Integer.parseInt(numbers[col]);
                    mapTile[col][row] = num;
                    col++;
                }
                if (col == maxCol) {
                    col = 0;
                    row++;
                }
            }
            bufferedReader.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public int[][] getMapTile() {
        return mapTile;
    }
}
