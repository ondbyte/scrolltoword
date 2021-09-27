import 'package:flutter/material.dart';
import 'package:scroll_to_word/scroll_to_word.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _word;
  late final ScrollToWordController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ScrollToWord example"),
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (s) {
                if (s.isNotEmpty) {
                  _word = s;
                } else {
                  _word = null;
                }
              },
              decoration: InputDecoration(
                labelText: "Sroll to word",
              ),
            ),
            TextButton.icon(
              onPressed: _search,
              icon: Icon(Icons.search),
              label: Text("scroll"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ScrollToWord(
                  highlightedWordStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.red),
                  scrollableData: damnBigText,
                  onScrollerCreated: (controller) {
                    _controller = controller;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search() {
    if (_word != null) {
      if (_word!.length > 3) {
        final match = _word!.allMatches(damnBigText);
        if (match.isNotEmpty) {
          _controller.scrollToWord(match.first.start, match.first.end);
        } else {
          print("no match");
        }
      }
    }
  }
}

const damnBigText =
    """Underpants figures out how to turn on the camcorder. He twists the little screen around so he can see himself in it. Framing himself waist-up, he takes a moment to gather his thoughts .•• then presses RECORD. 
UNDERPANTS MAN: My name is Walter Hartwell White. I live at 308 Belmont Avenue, Ontario, California 91764. I am of sound mind. To all law enforcement entities, this is not an admission of guilt. I'm speaking now to my family. (swallows hard) Skyler .•• you are ••• the love of my life. I hope you know that. Walter Junior. You're my big man. I should have told you things, both of you. I should have said things. But I love you both so much. And our unborn child. And I just want you to know that these .•• things you're going to learn about me in the coming days. These things. I just want you to know that •.• no matter what it may look like •.• I had all three of you in my heart.
The sirens are WAILING now, on top of us. WALTER WHITE, the underpants man, turns off the camcorder. He carefully sets it on a bare patch of ground by his feet. Next to it he sets his wallet, lying open where it can be seen. CLOSE ON the wallet --a photo ID card is visible. Walt's smiling face is on it. It identifies him as a teacher at J.P. wynne High School, Ontario Unified School District. Walt pulls the chrome pistol from the back of his waistband, aiming it across the tall weeds. It glints hard in the sun. Flashing red LIGHT BARS speed into view, skimming the tops of the weeds. Heading straight for us. Walt stands tall in his underpants, not flinching. Off him, ready to shoot the first cop he sees,
EXT. WHITE HOUSE -NIGHT No president ever slept here. No millionaire ever visited. This is a three-bedroom RANCHER in a modest neighborhood. Weekend trips to Home Depot keep it looking tidy, but it'll never make the cover of "Architectural Digest." We're in Ontario, California --the Inland Empire. LEGEND: "ONE MONTH EARLIER." INT. WHITE HOUSE -MASTER BEDROOM -NIGHT Dark and silent. SKYLER WHITE, late 30s, sleeps peacefully. Beside her, her husband Walter is wide awake. Walt reaches over and presses a button on his Sharper Image alarm clock. It projects the time in glowing blue numbers on the cottage cheese ceiling: 5:02 AM. Walt lies motionless. Brain churning. He presses the button again, staring straight up. 5:02 turns to 5:03. Close enough. Walt rises without waking his wife. He exits. INT. WHITE HOUSE -SPARE BEDROOM -NIGHT We hear an o.s. SQUEAK-SQUEAK as we drift through this room. We pass an empty crib, Pampers, a baby monitor still in its box. There's going to be a new addition to the family. We come upon the source of the SQUEAKING. It's Walt balanced on a Lillian Vernon stair-stepper, just three easy payments of 29.95. Walt plods up and down in the darkness like he's marching to Bataan. INT. WHITE HOUSE -BATHROOM -NIGHT Walt sits down on the 7dge of the tub. We're watching his face in the bathroom Mlrror. He masturbates. Judging by his expression, he might as well be waiting in line at the DMV. Walt double-takes, catching sight of himself. examines the sallow bagginess under his eyes. the loose skin under his chin. Distracted, he He draws at Staring at himself long and hard, Walt loses his erection. He gives up trying, pulls up his sweat pants. 
5. INT. WHITE HOUSE -KITCHEN -MORNING Walt is dressed for work --Dockers and a short-sleeve dress shirt courtesy of Target. An American flag pin on his tie. He and Skyler eat their breakfast in silence. Skyler glances up, sees Walt puzzling over his bacon. SKYLER Sizzle-Lean. We need to think about our cholesterol. WALT Huh. Skyler's cute in a way most guys wouldn't have noticed back in high school. But not soft-cute. Not in the eyes. She's dressed for staying home --she's five months pregnant and just beginning to show. SKYLER When'll you be home? WALT Same time. SKYLER I don't want him dicking you around tonight. You get paid till six, you work till six. Not seven. Seventeen year-old WALTER, JR. enters the kitchen, dressed for school, hair still damp from the shower. The CLICK ••• CLICK of his forearm crutches precedes him into the room. Walt and Skyler's son is a sweet-faced teenager who appears to have cerebral palsy. He moves slowly and awkwardly, and grinds his teeth as he labors to talk. But he's a smart kid. WALT Hey. Just seating himself at the table is a trial for Walter, Jr. His parents don't give him the slightest help. They treat him as if he were able-bodied, which is how he wants it. SKYLER You're late. He shrugs. She gets up, serves him breakfast. Walter, Jr. squints at the plate she plops down before him. 
WALTER, JR. What's--that? SKYLER Sizzle-lean. We're watching our cholesterol. WALTER, JR. Not--me! I want--bacon! SKYLER Eat it. Walter, Jr. picks at his breakfast, annoyed. WALTER, JR. What's this--even--made of?! He looks to his dad for backup. Walt shrugs, ambivalent. WALT Eat it. EXT. HIGH SCHOOL -MORNING 6. J.P. Wynne High School. Home of the Fightin' Skyhawks. Two thousand-plus students, many of them in overflow trailers. Into the faculty lot motors a 1991 Nissan wagon. It was a piece of shit when it rolled off the assembly line, and has not improved with age. It parks in a handicapped space. A handicapped placard hangs from the rear-view. Walt climbs out from behind the wheel, checks his watch. He's late. Walter, Jr. struggles to get out of the passenger side. He fumbles with his crutches and his backpack. WALT All set? (off his son's nod) Alright, see you at home. Walt grabs his briefcase and hurries toward the building, leaving his son to work it out for himself --which is, again, exactly how Walter, Jr. wants it. INT. HIGH SCHOOL -CLASSROOM -DAY Hours later. This is a chemistry classroom --black-topped lab tables with gas spigots. Walt is lecturing to seniors. """;
