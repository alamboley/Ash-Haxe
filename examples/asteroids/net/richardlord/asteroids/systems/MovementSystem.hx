package net.richardlord.asteroids.systems;

import ash.tools.ListIteratingSystem;

import net.richardlord.asteroids.GameConfig;
import net.richardlord.asteroids.components.Motion;
import net.richardlord.asteroids.components.Position;
import net.richardlord.asteroids.nodes.MovementNode;

class MovementSystem extends ListIteratingSystem<MovementNode>
{
    private var config:GameConfig;

    public function new(config:GameConfig)
    {
        this.config = config;
        super(MovementNode, updateNode);
    }

    private function updateNode(node:MovementNode, time:Float):Void
    {
        var position:Position = node.position;
        var motion:Motion = node.motion;

        position = node.position;
        motion = node.motion;
        position.position.x += motion.velocity.x * time;
        position.position.y += motion.velocity.y * time;
        if (position.position.x < 0)
        {
            position.position.x += config.width;
        }
        if (position.position.x > config.width)
        {
            position.position.x -= config.width;
        }
        if (position.position.y < 0)
        {
            position.position.y += config.height;
        }
        if (position.position.y > config.height)
        {
            position.position.y -= config.height;
        }
        position.rotation += motion.angularVelocity * time;
        if (motion.damping > 0)
        {
            var xDamp:Float = Math.abs(Math.cos(position.rotation) * motion.damping * time);
            var yDamp:Float = Math.abs(Math.sin(position.rotation) * motion.damping * time);
            if (motion.velocity.x > xDamp)
            {
                motion.velocity.x -= xDamp;
            }
            else if (motion.velocity.x < -xDamp)
            {
                motion.velocity.x += xDamp;
            }
            else
            {
                motion.velocity.x = 0;
            }
            if (motion.velocity.y > yDamp)
            {
                motion.velocity.y -= yDamp;
            }
            else if (motion.velocity.y < -yDamp)
            {
                motion.velocity.y += yDamp;
            }
            else
            {
                motion.velocity.y = 0;
            }
        }
    }
}
