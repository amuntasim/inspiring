import React from "react"
import PropTypes from "prop-types"
import { Modal,ModalManager,Effect} from 'react-dynamic-modal';
import StoryEditModal from './StoryEdit.js';

class StoryOptions extends React.Component {
    constructor(props) {
        super(props);
        this.story = this.props.story;
        this.currentUser = this.props.currentUser;
        this.state = {
            dropDownStatus: '',
            story: this.story
        }
    }

    toggleDropdown = () => {
        let dropDownStatus = this.state.dropDownStatus == '' ? 'clicked' : ''
        this.setState({
            dropDownStatus: dropDownStatus
        })
    }

    isOwner() {
       return (this.currentUser && this.currentUser.id == this.story.user.id)
    }

    openEditModal = () => {
        ModalManager.open(<StoryEditModal story={this.story} onRequestClose={() => true}/>);
    }

    render() {
        return (
            <span className={"dropdown pull-right " + this.state.dropDownStatus} onClick={this.toggleDropdown}>
                <i className="fa fa-ellipsis-v"></i>
                <span className="custom-dropdown-content">
                    {this.isOwner() &&
                    <span className=" text-center" onClick={this.openEditModal}>
                        <i className="sl sl-icon-pencil"></i> Edit
                    </span>
                    }
                    {this.isOwner() &&
                    <span className=" text-center">
                        <i className="fa fa-times"></i> Delete
                        </span>
                    }
                </span>
            </span>
        );
    }
}

StoryOptions.propTypes = {
    comment: PropTypes.object
};
export default StoryOptions
