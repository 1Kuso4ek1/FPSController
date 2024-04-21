FPSController@ player;
int cubes = 8;

void Start()
{
    Game::manageCameraMovement = false;
	Game::camera.SetPosition(Vector3(0, 2.7, 0));
	
    @player = @FPSController(Game::scene.GetModel("player"), Game::scene.GetModelGroup("ground"), 12.0, 500.0);

    for(int i = -cubes; i < cubes; i++)
        for(int j = -cubes; j < cubes; j++)
            Game::scene.CloneModel(Game::scene.GetModel("cube2:ground"), true, "cube-copy" + to_string(i + j)/* + ":ground"*/).SetPosition(Vector3(i * 10, 100, j * 10));
}

void Loop()
{
    player.Update();

    Game::camera.SetPosition(Game::scene.GetModel("player").GetPosition() + Vector3(0.0, 1.4, 0.0));
}
