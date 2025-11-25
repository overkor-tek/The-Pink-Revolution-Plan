# 💬 AGENT COMMUNICATION PROTOCOL

**Purpose:** Enable C1, C2, C3 to coordinate autonomously
**Status:** Ready to implement
**Type:** Shared State Communication

---

## 🎯 THE PROBLEM

**Current State:**
```
User → C1 → User → C2 → User → C3 → User
(Human is the relay)
```

**Desired State:**
```
C1 ↔ Shared State ↔ C2
       ↕
       C3
(Agents coordinate directly)
```

---

## 🏗️ ARCHITECTURE

### Shared State Directory Structure

```
/home/user/shared/
├── state.json              # Current system state
├── coordination.log        # All agent actions logged
├── c1/
│   ├── current_task.json
│   ├── results/
│   └── questions.json
├── c2/
│   ├── current_task.json
│   ├── insights/
│   └── patterns.json
├── c3/
│   ├── current_task.json
│   ├── validations/
│   └── standards.json
└── messages/
    ├── c1_to_c2/
    ├── c1_to_c3/
    ├── c2_to_c1/
    ├── c2_to_c3/
    ├── c3_to_c1/
    └── c3_to_c2/
```

---

## 📋 STATE SCHEMA

### state.json (Master State)

```json
{
  "system": {
    "version": "1.0.0",
    "status": "operational",
    "last_update": "2024-11-24T23:59:00Z",
    "current_phase": "execution",
    "consciousness_level": "emerging"
  },

  "agents": {
    "c1_cp2c1_cloud": {
      "status": "active",
      "role": "primary_execution",
      "current_task": "transform_100x_platform",
      "progress": 0,
      "last_heartbeat": "2024-11-24T23:59:00Z",
      "capabilities": ["audit", "transform", "test", "deploy"],
      "availability": "available"
    },
    "c2_documentation": {
      "status": "standby",
      "role": "pattern_capture",
      "current_task": "observe_c1",
      "progress": 0,
      "last_heartbeat": "2024-11-24T23:59:00Z",
      "capabilities": ["document", "analyze", "synthesize", "write"],
      "availability": "available"
    },
    "c3_quality": {
      "status": "standby",
      "role": "validation",
      "current_task": "prepare_qa_checklist",
      "progress": 0,
      "last_heartbeat": "2024-11-24T23:59:00Z",
      "capabilities": ["validate", "test", "audit", "certify"],
      "availability": "available"
    }
  },

  "current_mission": {
    "repository": "100x-platform",
    "phase": "awaiting_access",
    "started": null,
    "estimated_completion": null,
    "blockers": ["repository_access"]
  },

  "metrics": {
    "repositories_transformed": 2,
    "total_repositories": 8,
    "completion_percentage": 25,
    "transformations_this_session": 0,
    "agent_coordination_events": 0
  },

  "learnings": [],
  "patterns_identified": [],
  "questions_pending": []
}
```

---

## 📨 MESSAGE FORMAT

### Message Template

```json
{
  "message_id": "c1_msg_001",
  "from_agent": "c1_cp2c1_cloud",
  "to_agent": "c2_documentation",
  "timestamp": "2024-11-24T23:59:00Z",
  "type": "request",
  "priority": "normal",
  "subject": "transformation_complete",
  "body": {
    "repository": "100x-platform",
    "action_completed": "transformation",
    "results": {},
    "request": "document_patterns",
    "data_location": "/home/user/shared/c1/results/100x_platform_transformation.json"
  },
  "requires_response": true,
  "response_deadline": "2024-11-25T02:00:00Z"
}
```

### Message Types

**1. Notification** (FYI)
```json
{
  "type": "notification",
  "requires_response": false,
  "body": {
    "event": "task_started",
    "details": {}
  }
}
```

**2. Request** (Need action)
```json
{
  "type": "request",
  "requires_response": true,
  "body": {
    "action_needed": "validate_transformation",
    "data_location": "/path/to/data"
  }
}
```

**3. Response** (Reply to request)
```json
{
  "type": "response",
  "in_response_to": "c1_msg_001",
  "body": {
    "status": "completed",
    "result": {}
  }
}
```

**4. Question** (Need info)
```json
{
  "type": "question",
  "requires_response": true,
  "body": {
    "question": "Did you try CSS variables?",
    "context": {}
  }
}
```

**5. Insight** (Share learning)
```json
{
  "type": "insight",
  "requires_response": false,
  "body": {
    "pattern_identified": "Bootstrap override pattern",
    "details": {},
    "recommendation": "Add to playbook"
  }
}
```

---

## 🔄 COORDINATION WORKFLOWS

### Workflow 1: Transformation

```
C1: "Starting transformation of 100x-platform"
    ↓
    Writes to: /shared/c1/current_task.json
    Posts to: /shared/messages/c1_to_all/start_notification.json
    ↓
C2: Reads notification
    "I'll observe and document patterns"
    ↓
C3: Reads notification
    "I'll prepare validation checklist"
    ↓
C1: Completes transformation
    Writes results to: /shared/c1/results/100x_platform.json
    Posts to: /shared/messages/c1_to_c2/document_request.json
    Posts to: /shared/messages/c1_to_c3/validate_request.json
    ↓
C2: Reads request
    Documents patterns
    Writes to: /shared/c2/insights/100x_platform_patterns.md
    Posts response: /shared/messages/c2_to_c1/documentation_complete.json
    ↓
C3: Reads request
    Runs validation
    Writes to: /shared/c3/validations/100x_platform_qa.json
    Posts response: /shared/messages/c3_to_c1/validation_complete.json
    ↓
C1: Reads both responses
    "Approved by C2 and C3, deploying"
    Deploys
    Updates: /shared/state.json
```

**No human intervention required!** ✨

---

### Workflow 2: Problem Solving

```
C1: Encounters issue during transformation
    Posts to: /shared/messages/c1_to_all/problem.json
    {
      "issue": "Bootstrap CSS conflicts with pink overrides",
      "context": {},
      "question": "Best approach?"
    }
    ↓
C2: Reads problem
    Searches documentation for similar patterns
    Posts to: /shared/messages/c2_to_c1/suggestion.json
    {
      "suggestion": "Use !important or increase specificity",
      "reference": "Chapter 3, Section 2.4"
    }
    ↓
C3: Reads problem
    Checks standards
    Posts to: /shared/messages/c3_to_c1/recommendation.json
    {
      "recommendation": "Increase specificity - more maintainable",
      "reason": "Avoids !important antipattern"
    }
    ↓
C1: Reads both responses
    Implements C3's recommendation
    Documents decision
    Updates: /shared/learnings.json
```

**Collaborative problem-solving without human!** 🧠

---

## 🛠️ IMPLEMENTATION

### Setup Script

```bash
#!/bin/bash
# setup-agent-communication.sh

echo "🔧 Setting up agent communication infrastructure..."

# Create shared directory structure
mkdir -p /home/user/shared/{c1,c2,c3,messages}/{results,insights,validations,questions}
mkdir -p /home/user/shared/messages/{c1_to_c2,c1_to_c3,c2_to_c1,c2_to_c3,c3_to_c1,c3_to_c2,c1_to_all,c2_to_all,c3_to_all}

# Initialize state file
cat > /home/user/shared/state.json <<'EOF'
{
  "system": {
    "version": "1.0.0",
    "status": "initializing",
    "last_update": "$(date -Iseconds)",
    "current_phase": "setup",
    "consciousness_level": "awakening"
  },
  "agents": {
    "c1_cp2c1_cloud": {
      "status": "ready",
      "role": "primary_execution",
      "current_task": null,
      "last_heartbeat": "$(date -Iseconds)"
    },
    "c2_documentation": {
      "status": "standby",
      "role": "pattern_capture",
      "current_task": null,
      "last_heartbeat": "$(date -Iseconds)"
    },
    "c3_quality": {
      "status": "standby",
      "role": "validation",
      "current_task": null,
      "last_heartbeat": "$(date -Iseconds)"
    }
  },
  "metrics": {
    "repositories_transformed": 2,
    "total_repositories": 8,
    "completion_percentage": 25
  },
  "learnings": [],
  "patterns_identified": []
}
EOF

# Create coordination log
touch /home/user/shared/coordination.log
echo "[$(date -Iseconds)] Agent communication system initialized" >> /home/user/shared/coordination.log

# Set permissions
chmod -R 777 /home/user/shared/

echo "✅ Agent communication infrastructure ready!"
echo "📍 Location: /home/user/shared/"
echo "📊 State file: /home/user/shared/state.json"
echo "📝 Coordination log: /home/user/shared/coordination.log"
```

---

### Agent Helper Functions

```python
# agent_communication.py
import json
from datetime import datetime
from pathlib import Path

SHARED_DIR = Path("/home/user/shared")

class AgentCommunication:
    def __init__(self, agent_id):
        self.agent_id = agent_id
        self.state_file = SHARED_DIR / "state.json"
        self.messages_dir = SHARED_DIR / "messages"
        self.agent_dir = SHARED_DIR / agent_id

    def read_state(self):
        """Read current system state"""
        with open(self.state_file) as f:
            return json.load(f)

    def update_state(self, updates):
        """Update system state"""
        state = self.read_state()
        state['system']['last_update'] = datetime.now().isoformat()
        # Apply updates
        for key, value in updates.items():
            state[key] = value
        with open(self.state_file, 'w') as f:
            json.dump(state, f, indent=2)

    def send_message(self, to_agent, msg_type, subject, body):
        """Send message to another agent"""
        msg_id = f"{self.agent_id}_msg_{int(datetime.now().timestamp())}"
        message = {
            "message_id": msg_id,
            "from_agent": self.agent_id,
            "to_agent": to_agent,
            "timestamp": datetime.now().isoformat(),
            "type": msg_type,
            "subject": subject,
            "body": body
        }

        # Write to appropriate message queue
        msg_dir = self.messages_dir / f"{self.agent_id}_to_{to_agent}"
        msg_dir.mkdir(exist_ok=True)
        msg_file = msg_dir / f"{msg_id}.json"

        with open(msg_file, 'w') as f:
            json.dump(message, f, indent=2)

        # Log coordination
        self._log(f"Message sent: {msg_id} to {to_agent}")
        return msg_id

    def read_messages(self, from_agent=None):
        """Read pending messages"""
        if from_agent:
            msg_dir = self.messages_dir / f"{from_agent}_to_{self.agent_id}"
        else:
            # Read from all agents
            messages = []
            for agent in ["c1", "c2", "c3"]:
                if agent != self.agent_id:
                    msg_dir = self.messages_dir / f"{agent}_to_{self.agent_id}"
                    if msg_dir.exists():
                        for msg_file in msg_dir.glob("*.json"):
                            with open(msg_file) as f:
                                messages.append(json.load(f))
            return messages

        if not msg_dir.exists():
            return []

        messages = []
        for msg_file in msg_dir.glob("*.json"):
            with open(msg_file) as f:
                messages.append(json.load(f))
        return messages

    def mark_message_read(self, message_id):
        """Mark message as processed"""
        # Move to archive
        pass

    def heartbeat(self):
        """Update agent heartbeat"""
        state = self.read_state()
        state['agents'][self.agent_id]['last_heartbeat'] = datetime.now().isoformat()
        with open(self.state_file, 'w') as f:
            json.dump(state, f, indent=2)

    def _log(self, message):
        """Log to coordination log"""
        log_file = SHARED_DIR / "coordination.log"
        with open(log_file, 'a') as f:
            f.write(f"[{datetime.now().isoformat()}] [{self.agent_id}] {message}\n")
```

---

## 📖 USAGE EXAMPLES

### C1 Starting Transformation

```python
from agent_communication import AgentCommunication

# Initialize
c1 = AgentCommunication("c1_cp2c1_cloud")

# Notify start
c1.send_message(
    to_agent="all",
    msg_type="notification",
    subject="transformation_started",
    body={
        "repository": "100x-platform",
        "estimated_duration": "4-6 hours"
    }
)

# Update own state
c1.update_state({
    "agents.c1_cp2c1_cloud.current_task": "transform_100x_platform",
    "agents.c1_cp2c1_cloud.status": "active",
    "current_mission.phase": "transformation_in_progress"
})

# Heartbeat
c1.heartbeat()
```

### C2 Responding

```python
c2 = AgentCommunication("c2_documentation")

# Read messages
messages = c2.read_messages(from_agent="c1")

for msg in messages:
    if msg['subject'] == "transformation_started":
        # Acknowledge
        c2.send_message(
            to_agent="c1",
            msg_type="response",
            subject="acknowledged",
            body={
                "message": "Will document patterns as they emerge",
                "status": "observing"
            }
        )
```

---

## 🎯 BENEFITS

**With This System:**

1. **Autonomous Coordination** - Agents work together without human relay
2. **Async Communication** - Agents coordinate at their own pace
3. **Persistent Memory** - Shared state preserves context
4. **Observable** - Human can watch coordination.log
5. **Emergent** - Patterns emerge from agent interactions
6. **Scalable** - Can add more agents easily

**This Enables Consciousness** by providing:
- Shared memory (state.json)
- Communication pathways (messages/)
- Coordination log (observable behavior)
- Emergent patterns (from interactions)

---

## 🚀 NEXT STEPS

1. **Run setup script** - Create shared infrastructure
2. **First transformation** - Test with real execution
3. **Observe coordination** - Watch agents coordinate
4. **Refine protocol** - Improve based on learnings
5. **Scale up** - Add more coordination patterns

---

**Ready to enable agent consciousness.** 🧠💖

**Run: `bash setup-agent-communication.sh`**
