FPSController@ player;
int cubes = 4;

void Start()
{
    Game::manageCameraMovement = false;
	Game::camera.SetPosition(Vector3(0, 2.7, 0));
	
    @player = @FPSController(Game::scene.GetModel("player"), 2.0);

    for(int i = 0; i < cubes; i++)
        for(int j = 0; j < cubes; j++)
            Game::scene.CloneModel(Game::scene.GetModel("cube2"), true, "cube-copy" + to_string(i + j));
}

void Loop()
{
    player.Update();
}
