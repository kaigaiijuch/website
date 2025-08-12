// Zapier Code Script: Post Slack message and trigger GitHub Action
// Usage: This script should be used in a Zapier "Code by Zapier" action
// Input data from previous Zapier steps (customize as needed)

// Validate input data
if (!inputData.SLACK_WEBHOOK_URL) {
  throw new Error('Missing required input: SLACK_WEBHOOK_URL');
}
if (!inputData.GITHUB_TOKEN) {
  throw new Error('Missing required input: GITHUB_TOKEN');
}
if (!inputData.SLACK_WEBHOOK_URL.startsWith('https://hooks.slack.com/')) {
  throw new Error('Invalid SLACK_WEBHOOK_URL format');
}

// Configuration - Set these in Zapier environment or hardcode
const SLACK_WEBHOOK_URL = inputData.SLACK_WEBHOOK_URL;
const GITHUB_TOKEN = inputData.GITHUB_TOKEN;
const NEW_EPISODE_TITLE = inputData.NEW_EPISODE_TITLE;
const NEW_EPISODE_URL = inputData.NEW_EPISODE_URL;
const GITHUB_REPO_OWNER = 'kaigaiijuch';
const GITHUB_REPO_NAME = 'website';

async function postSlackMessage() {
  const slackMessage = {
    text: `🎙️ New episode detected: <${NEW_EPISODE_URL}|${NEW_EPISODE_TITLE}>\nStart deploying website :rocket:...`,
  };

  try {
    const response = await fetch(SLACK_WEBHOOK_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(slackMessage)
    });

    if (!response.ok) {
      throw new Error(`Slack API error: ${response.status} ${response.statusText}`);
    }

    console.log('Slack message posted successfully');
    return { success: true, message: 'Slack notification sent' };
  } catch (error) {
    console.error('Failed to post Slack message:', error);
    throw error;
  }
}

async function triggerGitHubAction() {
  const url = `https://api.github.com/repos/${GITHUB_REPO_OWNER}/${GITHUB_REPO_NAME}/dispatches`;

  const payload = {
    event_type: 'fetch_rss',
    client_payload: {
      triggered_by: 'zapier',
      timestamp: new Date().toISOString()
    }
  };

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Authorization': `token ${GITHUB_TOKEN}`,
        'Accept': 'application/vnd.github.v3+json',
        'Content-Type': 'application/json',
        'User-Agent': 'Zapier-Bot'
      },
      body: JSON.stringify(payload)
    });

    if (!response.ok) {
      const errorBody = await response.text();
      throw new Error(`GitHub API error: ${response.status} ${response.statusText} - ${errorBody}`);
    }

    console.log('GitHub Action triggered successfully');
    return { success: true, message: 'GitHub Action triggered' };
  } catch (error) {
    console.error('Failed to trigger GitHub Action:', error);
    throw error;
  }
}

// Main execution
async function main() {
  try {
    // Post Slack message first
    const slackResult = await postSlackMessage();

    // Trigger GitHub Action
    const githubResult = await triggerGitHubAction();

    // Return results to Zapier
    return {
      success: true,
      slack_result: slackResult,
      github_result: githubResult,
      message: 'Both Slack notification and GitHub Action triggered successfully'
    };
  } catch (error) {
    console.error('Script execution failed:', error);
    return {
      success: false,
      error: error.message,
      message: 'Failed to execute script'
    };
  }
}

// Execute the main function
return await main();
