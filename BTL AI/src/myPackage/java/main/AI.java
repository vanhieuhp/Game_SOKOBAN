package myPackage.java.main;

import myPackage.java.entity.Player;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;

public class AI {
    public Player player;
    public String mapString;
    public String AIString;
    public List<String> lines;
    private int playerResult;
    private int gameResult;
    GamePanel gp;
    public int count = 0;

    public AI(Player player, GamePanel gp) {
        this.gp = gp;
        this.player = player;
        this.count = gp.numOfMap;
        this.mapString = "/myPackage/assets/key/" + count + ".txt";
        loadAIString(mapString);

    }

    public void loadAIString(String string) {
        try {
            InputStream inputStream = getClass().getResourceAsStream(string);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

            lines = new ArrayList<>();
            String line = bufferedReader.readLine();
            while (line != null) {
                lines.add(line);
                line = bufferedReader.readLine();
            }
            Collections.sort(lines, (o1, o2) -> (int) (o1.length() - o2.length()));
            this.AIString = lines.get(0);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void AIRun() {
        String[] directions = AIString.split(" ");
        Timer t = new Timer();
        TimerTask tt = new TimerTask() {
            int length = directions.length;
            int i = 0;
            @Override
            public void run() {
                if (i < length) {
                    String direction = directions[i];
                    switch (direction) {
                        case "up":
                            player.checkCollision.check(direction);
                            player.locationY -= gp.tileSize;
                            break;
                        case "down":
                            player.checkCollision.check(direction);
                            player.locationY += gp.tileSize;
                            break;
                        case "left":
                            player.checkCollision.check(direction);
                            player.locationX -= gp.tileSize;
                            break;
                        case "right":
                            player.checkCollision.check(direction);
                            player.locationX += gp.tileSize;
                            break;
                    }
                    i++;
                } else {

                }
            }
        };
        t.schedule(tt, new Date(), 500);
    }

    public double statistic() {
        String playerString = gp.keyHandler.AIString;
        String[] playerResults = playerString.split(" ");
        String[] gameResults = AIString.split(" ");
        playerResult = playerResults.length;
        gameResult = gameResults.length;
        double point = 0;
        if (playerResult <= gameResult) {
            point = 10;
        } else {
            point = (double) gameResult / playerResult;
            point = Math.round(point*100.0)/ (10.0);
        }
        return point;
    }

    public String assess() {
        String comment;
        if (lines.size() < 10) {
            int index = lines.size() / 3;
            if (index == 0) {
                index = lines.size() - 1;
            }
            if (lines.get(0).split(" ").length >= playerResult) {
                comment = "Excellent";
            } else if (lines.get(index).split(" ").length >= playerResult) {
                comment = "Good";
            } else {
                comment = "Fair";
            }
        } else if ( (lines.size() % 10) > 0 ) {
            int index = lines.size() / 5;
            if (lines.get(index).split(" ").length >= playerResult) {
                comment = "Excellent";
            } else if (lines.get(2 * index).split(" ").length >= playerResult) {
                comment = "Good";
            } else {
                comment = "Fair";
            }
        } else if ( (lines.size() % 100) > 0 ) {
            int index = lines.size() / 10;
            if (lines.get(2*index).split(" ").length >= playerResult) {
                comment = "Excellent";
            } else if (lines.get(6 * index).split(" ").length >= playerResult) {
                comment = "Good";
            } else {
                comment = "Fair";
            }
        } else {
            int index = lines.size() / 100;
            if (lines.get(2*index).split(" ").length >= playerResult) {
                comment = "Excellent";
            } else if (lines.get(6 * index).split(" ").length >= playerResult) {
                comment = "Good";
            } else {
                comment = "Fair";
            }
        }
        return comment;
    }
}
