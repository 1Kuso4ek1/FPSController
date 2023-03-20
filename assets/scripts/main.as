Model@ player;
float maxSpeed = 2;

void Start()
{
    Game::manageCameraMovement = false;
	Game::camera.SetPosition(Vector3(0, 2.7, 0));
	
    @player = @Game::scene.GetModel("player");
    //player.GetRigidBody().setMass(0.1);
}

void Loop()
{
    player.SetOrientation(Quaternion(0, 0, 0, 1));
    auto v = Game::camera.Move(1, true); v.y = 0; v *= 300;
    player.GetRigidBody().applyWorldForceAtCenterOfMass(v);

    auto vel = player.GetRigidBody().getLinearVelocity();
    if(vel.x > maxSpeed) vel.x = maxSpeed; if(vel.z > maxSpeed) vel.z = maxSpeed;
    if(vel.x < -maxSpeed) vel.x = -maxSpeed; if(vel.z < -maxSpeed) vel.z = -maxSpeed;
    player.GetRigidBody().setLinearVelocity(vel);

    if(v == Vector3(0, 0, 0))
        player.GetRigidBody().setLinearVelocity(
            Vector3(player.GetRigidBody().getLinearVelocity().x / 1.5,
            player.GetRigidBody().getLinearVelocity().y,
            player.GetRigidBody().getLinearVelocity().z / 1.5));
}
