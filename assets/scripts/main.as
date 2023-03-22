FPSController@ player;

void Start()
{
    Game::manageCameraMovement = false;
	Game::camera.SetPosition(Vector3(0, 2.7, 0));
	
    @player = @FPSController(Game::scene.GetModel("player"), 2.0);
}

void Loop()
{
    player.Update();
}
