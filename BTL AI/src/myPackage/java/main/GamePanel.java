package myPackage.java.main;

import myPackage.java.entity.Boxes;
import myPackage.java.entity.Player;
import myPackage.java.map.Map;
import myPackage.java.map.TileManager;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.*;
import java.util.Timer;

public class GamePanel extends JPanel implements Runnable {
    final int FPS = 20;
    final int originalTileSize = 20;
    final int scale = 3;
    public int tileSize = scale * originalTileSize;
    public JPanel panel;
    public int maxScreenCol;
    public int maxScreenRow;
    public int screenWidth;
    public int screenHeight;
    public int numOfMap;

    public Thread gameThread;
    Boxes aBox;
    KeyHandler keyHandler;
    Player player;
    public Map map;
    TileManager tileManager;
    OpenGame openGame;
    public AI AISupport;

    public JButton bGameAgain;
    public JButton bAISupport;
    public JButton bScores;
    public JLabel point;
    public JLabel assess;

    GamePanel(OpenGame openGame) {
        map = new Map(openGame.count);
        this.openGame = openGame;
        openGame.frame.setVisible(false);
        this.numOfMap = openGame.count;
        this.tileManager = new TileManager(this);
        this.aBox = new Boxes(this);
        this.keyHandler = new KeyHandler(this);
        this.player = new Player(this, keyHandler, aBox.boxes);
        this.keyHandler.setPlayer(player);
        this.addKeyListener(keyHandler);
        this.setFocusable(true);
        this.AISupport = new AI(player, this);
        setMap();
        loadMap();


        // button
        bGameAgain = new JButton("Game Again");
        setButton(bGameAgain);
        bGameAgain.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                openGame.frame.setVisible(true);
                openGame.window.setVisible(false);
            }
        });

        bAISupport = new JButton("AI support");
        setButton(bAISupport);
        bAISupport.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                keyHandler.AIString = "";
                map.loadMap(map.mapPath);
                aBox.tileMap = map.getMapTile();
                player.checkCollision.mapTile = map.getMapTile();
                tileManager.mapTile = map.getMapTile();
                setMap();
                aBox.setLocation();
//                AISupport.loadAIString(AISupport.mapString);
                Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    int i = 0;
                    @Override
                    public void run() {
                        if (i == 0) {
                            i++;
                        }
                        if (i == 1) {
                            AISupport.AIRun();
                        }
                    }
                }, 2000);
            }
        });

        panel = new JPanel();
        panel.setBackground(Color.ORANGE);
        panel.setPreferredSize(new Dimension(160, 540));
        panel.add(bGameAgain, BorderLayout.CENTER);
        panel.add(bAISupport, BorderLayout.SOUTH);
        openGame.window.add(panel, BorderLayout.EAST);

    }

    public void setMap() {
        maxScreenCol = map.maxCol;
        maxScreenRow = map.maxRow;
        player.locationX = map.positionX * tileSize;
        player.locationY = map.positionY * tileSize;
        screenWidth = maxScreenCol * tileSize;
        screenHeight = maxScreenRow * tileSize;
    }

    public void loadMap() {
        this.setPreferredSize(new Dimension(screenWidth, screenHeight));
        this.setBackground(Color.black);
        this.setDoubleBuffered(true);
    }

    public void startGame() {
        gameThread = new Thread(this);
        gameThread.start();
    }

    @Override
    public void run() {
        double drawInterval = 1000000000 / FPS;
        double delta = 0;
        long lastTime = System.nanoTime();
        long currentTime;
        long timer = 0;
        int drawCount = 0;
        while (gameThread != null) {
            currentTime = System.nanoTime();

            delta += (currentTime - lastTime) / drawInterval;
            timer += (currentTime - lastTime);
            lastTime = currentTime;

            if (delta >= 1) {
                repaint();
                delta--;
                drawCount++;
            }
            if (timer >= 1000000000) {
                drawCount = 0;
                timer = 0;
            }
        }
    }

    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2 = (Graphics2D) g;

        //draw map
        tileManager.draw(g2);

        //draw object
        aBox.draw(g2);

        //draw player
        player.draw(g2);// more function than Graphics

    }


    public TileManager getTileManager() {
        return tileManager;
    }

    public void setLevelMap(int aLevelMap) {
        int levelMap = aLevelMap;
    }

    public void setButton(Object object) {
        if (object.getClass() == JButton.class) {
            JButton button = (JButton) object;
            Font font = new Font("Arial", Font.ITALIC | Font.BOLD, 20);
            button.setBorder(BorderFactory.createEmptyBorder());
            button.setBackground(Color.ORANGE);
            button.setForeground(Color.WHITE);
            button.setFont(font);
            button.setFocusPainted(false);
        } else if (object.getClass() == JLabel.class) {
            JLabel label = (JLabel) object;
            Font font = new Font("Arial", Font.ITALIC | Font.BOLD, 20);
            label.setBorder(BorderFactory.createEmptyBorder());
            label.setBackground(Color.ORANGE);
            label.setForeground(Color.WHITE);
            label.setFont(font);
        }

    }
}
